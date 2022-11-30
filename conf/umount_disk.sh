#!/bin/bash
if [ "$VIRTUALISATION" = "true" ] 
then
     datadir=__DATADIR__
    nbd=$(cat $datadir/nbd_index)
    umount  /dev/nbd$nbd
    qemu-nbd --disconnect  /dev/nbd$nbd
fi
