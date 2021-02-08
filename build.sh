#!/bin/sh
#
# This script assembles the Rock Runner code and
# creates a floppy disk image with the result.
#
# We're compiling both the ROM (code and data)
# and the GROM (pure data) with xas99.
#
# Useful xas99 option for debugging:
#   --listing-file out/rom.lst

mkdir -p out \
&& xas99.py --register-symbols --binary --output out/rom  main.asm \
&& xas99.py --register-symbols --binary --output out/grom worlds/all.asm \
&& zip --junk-paths out/RockRunner.rpk layout.xml out/rom out/grom
