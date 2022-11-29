#!/bin/bash
if [ "$VIRTUALISATION" = "true" ] 
then
    final_path=__FINALPATH__
    format=$1
    i=0
    while $(fdisk -l /dev/nbd$i  1&>2 /dev/null)
    do
        i=$(( i + 1 ))
    done
    echo $i
    modprobe nbd max_part=$(( i + 1 ))
    qemu-nbd --connect /dev/nbd$i $final_path/garage_data.qcow2
    if [[ "$format" = "true" ]]
    then
        mkfs.ext4 /dev/nbd$i > /dev/null
    fi
    mount /dev/nbd$i $datadir/data/
fi
