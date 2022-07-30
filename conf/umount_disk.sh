#!bash
datadir=$1
format=$2
i=0
while $(fdisk -l /dev/nbd$i  1&>2 /dev/null)
do
	i=$(( i + 1 ))
done
echo $i
modprobe nbd max_part=$(( i + 1 ))
qemu-nbd --connect /dev/nbd$i $datadir/garage.qcow2
if [[ "$format" = "true" ]]
then
    mkfs.ext4 /dev/nbd$i > /dev/null
fi
mount /dev/nbd$i $datadir/data/
