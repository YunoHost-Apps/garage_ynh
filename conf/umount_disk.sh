#!/bin/bash
if [ "$VIRTUALISATION" = "true" ] 
then
    nbd=__NBD_INDEX__
    umount  /dev/nbd$nbd
    qemu-nbd --disconnect  /dev/nbd$nbd
fi
