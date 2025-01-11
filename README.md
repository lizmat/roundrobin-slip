[![Actions Status](https://github.com/lizmat/roundrobin-slip/actions/workflows/linux.yml/badge.svg)](https://github.com/lizmat/roundrobin-slip/actions) [![Actions Status](https://github.com/lizmat/roundrobin-slip/actions/workflows/macos.yml/badge.svg)](https://github.com/lizmat/roundrobin-slip/actions) [![Actions Status](https://github.com/lizmat/roundrobin-slip/actions/workflows/windows.yml/badge.svg)](https://github.com/lizmat/roundrobin-slip/actions)

NAME
====

roundrobin-slip - Provide roundrobin(:slip) for older Rakus

SYNOPSIS
========

```raku
use roundrobin-slip;

.say for roundrobin((1,2), (3,4));        # (1 3)␤(2 4)␤

.say for roundrobin((1,2), (3,4), :slip); # 1␤3␤2␤4␤
```

DESCRIPTION
===========

roundrobin-slip is a distribution that provides an extra candidate for the [roundrobin](https://docs.raku.org/routine/roundrobin) function that will automatically [slip](https://docs.raku.org/routine/slip) all values that are produced.

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/roundrobin-slip . Comments and Pull Requests are welcome.

If you like this module, or what I’m doing more generally, committing to a [small sponsorship](https://github.com/sponsors/lizmat/) would mean a great deal to me!

COPYRIGHT AND LICENSE
=====================

Copyright 2021, 2024, 2025 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

