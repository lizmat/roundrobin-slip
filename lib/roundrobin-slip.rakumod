use nqp;  # intended to also go in core

my $empty := nqp::list;  # for removing elements with nqp::splice

# Return an iterator that will slip all values of the given iterables
# roundrobinly.  Basically the functionality of roundrobin(@a,@b, :slip)
my class RoundrobinIterablesSlipped does Iterator {
    has $!iters;
    has $.is-lazy;
    has int $!i;
    method !SET-SELF(\iterables) {
        my $iterables := nqp::getattr(iterables,List,'$!reified');
        my int $elems = nqp::elems($iterables);
        $!iters   := nqp::setelems(nqp::list,$elems);
        $!is-lazy := False;

        my int $i = -1;
        nqp::while(
          nqp::islt_i(($i = nqp::add_i($i,1)),$elems),
          nqp::bindpos($!iters,$i,
            nqp::if(
              nqp::iscont(my $elem := nqp::atpos($iterables,$i)),
              Rakudo::Iterator.OneValue($elem),
              nqp::stmts(
                nqp::if($elem.is-lazy,($!is-lazy := True)),
                $elem.iterator
              )
            )
          )
        );
        self
    }
    method new(\iterables) { nqp::create(self)!SET-SELF(iterables) }
    method pull-one() {
        nqp::while(
          nqp::islt_i($!i,nqp::elems($!iters))
            && nqp::eqaddr(
                 (my $pulled := nqp::atpos($!iters,$!i).pull-one),
                 IterationEnd
               ),
          nqp::stmts(
            nqp::splice($!iters,$empty,$!i,1),       # remove exhausted
            nqp::if(                                 # check at same index
              nqp::isge_i($!i,nqp::elems($!iters)),  # unless it was last
              ($!i = 0)
            )
          )
        );
        $!i = 0 if nqp::isge_i(++$!i,nqp::elems($!iters));
        $pulled
    }
}

multi sub roundrobin(+lol, :$slip!) is export {
    Seq.new: nqp::isgt_i(lol.elems,0)  # reifies
      ?? RoundrobinIterablesSlipped.new(lol)
      !! Rakudo::Iterator.Empty
}

sub EXPORT() {
    (try &CORE::roundrobin(1, :slip))
      ?? Map.new    # already in core
      !! Map.new( ('&roundrobin' => &roundrobin) )
}

=begin pod

=head1 NAME

roundrobin-slip - Provide roundrobin(:slip) for older Rakus

=head1 SYNOPSIS

=begin code :lang<raku>

use roundrobin-slip;

.say for roundrobin((1,2), (3,4));        # (1 3)␤(2 4)␤

.say for roundrobin((1,2), (3,4), :slip); # 1␤3␤2␤4␤

=end code

=head1 DESCRIPTION

roundrobin-slip is a distribution that provides an extra candidate for
the L<roundrobin|https://docs.raku.org/routine/roundrobin> function that
will automatically L<slip|https://docs.raku.org/routine/slip> all values
that are produced.

=head1 AUTHOR

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/roundrobin-slip .
Comments and Pull Requests are welcome.

If you like this module, or what I’m doing more generally, committing to a
L<small sponsorship|https://github.com/sponsors/lizmat/>  would mean a great
deal to me!

=head1 COPYRIGHT AND LICENSE

Copyright 2021, 2024 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
