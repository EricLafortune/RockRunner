#!/bin/sh
#
# This script assembles the Rock Runner code and
# creates a floppy disk image with the result.

mkdir -p out \
&& xas99.py --register-symbols --image --output out/rock main.asm \
&& xdm99.py out/rock.dsk -X SSSD -a out/roc?
