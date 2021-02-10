#!/bin/sh
#
# This script assembles the Rock Runner code and
# creates an RPK cartridge image with the result.
#
# We're compiling both the ROM (code and data)
# and the GROM (pure data) with xas99.
#
# We're packaging the output as an RPK for Mame,
# using the ROM naming convention for FinalGROM 99.
#
# Useful xas99 option for debugging:
#   --listing-file out/rom.lst

mkdir -p out \
&& xas99.py --register-symbols --binary --output out/romc.bin main.asm \
&& xas99.py --register-symbols --binary --output out/romg.bin worlds/all.asm \
&& rm -f out/RockRunner.rpk \
&& zip --junk-paths out/RockRunner.rpk layout.xml out/romc.bin out/romg.bin
