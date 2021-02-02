#!/bin/sh
#
# This script launches Mame with the TI-99/$A, the Editor/Assembler cartridge,
# the 32K memory expansion, the speech synthesizer, the floppy drive, and the
# Rock Runner floppy disk mounted.
#
# You can  then start the game from the Editor/Assembler module:
#   Press any key
#   2. Editor/Assembler
#   5. Load program file
#      DSK1.ROCK

RPK=${1:-EditorAssembler.rpk}
DSK=out/rock.dsk

if [ ! -f $RPK ]
then
  echo "Can't find the Editor/Assembler cartridge image $RPK"
  echo "Please specify the correct path as an argument"
  exit 1
fi

if [ ! -f $DSK ]
then
  echo "Can't find the Rock Runner floppy disk image $DSK"
  echo "Please build it with the build.sh script"
  exit 1
fi

mame ti99_4a \
  -ioport peb \
  -ioport:peb:slot2 32kmem \
  -ioport:peb:slot3 speech \
  -ioport:peb:slot8 tifdc \
  -cart1 $RPK \
  -flop1 $DSK
