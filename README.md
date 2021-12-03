[![Actions Status](https://github.com/lizmat/roundrobin-slip/workflows/test/badge.svg)](https://github.com/lizmat/roundrobin-slip/actions)

NAME
====

roundrobin-slip - Provide roundrobin(:slip) for older Rakus

SYNOPSIS
========

```raku
use roundrobin::slip;
.say for roundrobin((1,2), (3,4), :slip); # 1␤3␤2␤4␤
```

DESCRIPTION
===========

roundrobin-slip is a distribution that provides an extra candidate for the `roundrobin` function that will automatically `slip` all values that are produced.

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

COPYRIGHT AND LICENSE
=====================

Copyright 2021 Elizabeth Mattijsen

Source can be located at: https://github.com/lizmat/roundrobin-slip . Comments and Pull Requests are welcome.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.
