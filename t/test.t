#!/usr/bin/env bash

# Copyright © 2020 Jakub Wilk <jwilk@jwilk.net>
# SPDX-License-Identifier: MIT

set -e -u
pdir="${0%/*}/.."
prog="$pdir/dsizcalculia"
echo 1..1
xout='virtual size:
- width:     1280 px
- height:    1024 px
- diameter:  1639 px
- area:      1.31 Mpx

physical size:
- width:      298 mm
- height:     238 mm
- diameter:   381 mm
- area:       708 cm²

physical size of one pixel:
- width:     0.23 mm
- height:    0.23 mm
- area:     0.054 mm²

4:3 movie size:
- width:      298 mm
- height:     223 mm
- diameter:   372 mm
- area:       664 cm²

16:9 movie size:
- width:      298 mm
- height:     167 mm
- diameter:   341 mm
- area:       498 cm²'
out=$("$prog" 1280 1024 15)
say() { printf "%s\n" "$@"; }
diff=$(diff -u <(say "$xout") <(say "$out")) || true
if [ -z "$diff" ]
then
    echo 'ok 1'
else
    sed -e 's/^/# /' <<< "$diff"
    echo 'not ok 1'
fi

# vim:ts=4 sts=4 sw=4 et ft=sh
