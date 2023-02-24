#!/bin/bash
if [ "$VIRTUALISATION" = "true" ] 
then
    datadir=__DATADIR__
    format=$1
    i=0
    while fdisk -l /dev/nbd$i  1> /dev/null 2> /dev/null
    do
        i=$(( i + 1 ))
    done
    echo $i > $datadir/nbd_index
    modprobe nbd max_part=$(( i + 1 ))
    qemu-nbd --connect /dev/nbd$i $datadir/garage_data.qcow2
    if [[ "$format" = "true" ]]
    then
        echo "formatting /dev/nbd$i"
        mkfs.ext4 /dev/nbd$i
    fi
    mkdir -p $datadir/data
    chown  __APP__:__APP__  $datadir/data
    mount /dev/nbd$i $datadir/data/
fi


