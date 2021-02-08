#!/bin/sh
#
# This script launches Mame with the TI-99/4A, the 32K memory expansion,
# the speech synthesizer, and the Rock Runner cartridge mounted.
#
# You can  then start the game:
#   Press any key
#   2. Rock Runner
#
# Useful Mame options for debugging:
#   -nomouse -debug

RPK=out/RockRunner.rpk

if [ ! -f $RPK ]
then
  echo "Can't find the cartridge image $RPK"
  echo "Please build it with the build.sh script"
  exit 1
fi

mame ti99_4a \
  -ioport peb \
  -ioport:peb:slot2 32kmem \
  -ioport:peb:slot3 speech \
  -cart1 $RPK
