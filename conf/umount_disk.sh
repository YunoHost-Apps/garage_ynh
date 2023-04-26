#!/bin/bash
if [ "$VIRTUALISATION" = "true" ] 
then
     data_dir=__DATA_DIR__
    nbd=$(cat $data_dir/nbd_index)
    umount  /dev/nbd$nbd
    qemu-nbd --disconnect  /dev/nbd$nbd
fi
