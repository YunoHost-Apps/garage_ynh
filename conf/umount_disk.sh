#!/bin/bash
if [ "$VIRTUALISATION" = "true" ] 
then
    nbd=$1
    umount  /dev/nbd$nbd
    qemu-nbd --disconnect  /dev/nbd$nbd
fi
