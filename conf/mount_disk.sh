#!/bin/bash

# If we're inside a container
if systemd-detect-virt -c -q
then
    data_dir=__DATA_DIR__
    format=$1
    i=0
    while fdisk -l /dev/nbd$i  1> /dev/null 2> /dev/null
    do
        i=$(( i + 1 ))
    done
    echo $i > $data_dir/nbd_index
    modprobe nbd max_part=$(( i + 1 ))
    qemu-nbd --connect /dev/nbd$i $data_dir/garage_data.qcow2
    if [[ "$format" = "true" ]]
    then
        echo "formatting /dev/nbd$i"
        mkfs.ext4 /dev/nbd$i
    fi
    mkdir -p $data_dir/data
    chown  __APP__:__APP__  $data_dir/data
    mount /dev/nbd$i $data_dir/data/
fi


