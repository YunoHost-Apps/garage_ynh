#!/bin/bash

# If we're NOT inside a container
if ! systemd-detect-virt -c -q
then
    data_dir=__DATA_DIR__
    nbd=$(cat $data_dir/nbd_index)
    umount  /dev/nbd$nbd
    qemu-nbd --disconnect  /dev/nbd$nbd
fi
