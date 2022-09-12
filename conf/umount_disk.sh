#!/bin/bash
nbd=$1
umount  /dev/nbd$nbd
qemu-nbd --disconnect  /dev/nbd$nbd
