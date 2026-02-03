#!/bin/bash

#=================================================
# COMMON VARIABLES AND CUSTOM HELPERS
#=================================================

metadata_is_btrfs() {
    df -Th $data_dir/metadata | grep -q "btrfs"
}

system_is_inside_container() {
    systemd-detect-virt  -c -q
}

garage="$install_dir/garage -c $install_dir/garage.toml"

garage_meta_snapshot() {
    $garage meta snapshot
}

garage_meta_snapshot_restore() {
    # find how to restore metdata snapshot
    last_snapshot=$(ls -t $data_dir/snapshots | head -n1)
    cp -r $data_dir/snapshots/$last_snapshot $data_dir/metadata/db.lmdb
}

garage_connect() {
    local peer="$1"
    # connect to cluster
    $garage node connect "$peer"
    sleep 2
    # wait until layout is updated
    local i=0
    until $garage layout show 2>/dev/null | grep "${peer:0:15}"; do
        i=$(( i + 1 ))
        [ $i -le 30 ] || ynh_die "Unable to get layout from remote peer"
        sleep 1
    done
}

garage_layout_apply() {
	$garage layout show 2>/dev/null
	if $garage layout show | grep -q 'This new layout cannot yet be applied'
	then
        ynh_print_warn "Unable to apply layout. No enough nodes"
		return 0
    fi

    local layout_version=$($garage layout show 2>/dev/null | grep -Po -- "(?<=--version).*" | head -1 | xargs)
    $garage layout apply --version $layout_version
}

mount_data() {
    # If we're NOT inside a container and the user did not provide a Data partition
    if ! $app_install_inside_container && [[ "$data" == "no" ]]
    then
        ynh_print_warn "Creating garage_data.qcow2 may take time regarding disk size..."
        
        # to be sure to not exceed size limit, i use a virtual disk with a fix size to have a max limit size.
        qemu-img create -f qcow2 $data_dir/garage_data.qcow2 "$weight"G
        mount_disk "xfs"
        umount_disk
        # https://mattgadient.com/how-to-using-systemd-to-mount-nbd-devices-on-boot-ubuntu/
        ynh_config_add_systemd --mount="$app""_data" --template=data.mount
        yunohost service add garage_data_mounted --description="Garage Data Mounted" --log="/var/log/$app/$app.log"
        ynh_systemctl --service=garage_data_mounted --action="start" # --wait_until="Started Garage: Data Mount"
    elif ! $app_install_inside_container
    then
        ynh_print_info "Mounting Garage Data with systemd..."
    #    mkdir -p $data_dir/data # /home/yunohost.app/garage/data
        mkfs.xfs -L data_xfs -m crc=1 "$data"
        # Get UUID of new partition
        data_uuid=$(blkid -s UUID -o value "$data")
        # Edit `/etc/fstab` to auto-mount Garage Data `$data_dir/data` on new partition
        #echo "# mount SSD/HDD part $data with xfs filesystem for garage" | tee -a /etc/fstab
        #echo "UUID=$data_uuid $data_dir/data xfs defaults 0 0" | tee -a /etc/fstab
        # Mount Garage Data `$data_dir/data` on new partition
        ynh_config_add_systemd --mount="$app""_data" --template=data.mount
        yunohost service add garage_data_mounted --description="Garage Data Mounted" --log="/var/log/$app/$app.log"
        ynh_systemctl --service=garage_data_mounted --action="start" # --wait_until="Started Garage: Data Store"
    # else we are in a container, we keep all partitions as is
    #mkdir -p $data_dir/data # /home/yunohost.app/garage/data
    fi
}

mount_metadata() {
    metadata_ratio=2 # % of the data size reserved for metadata
    metadata_size=$(( $metadata_ratio * ( $weight + 100/2 ) / 100 )) # X / Y rounded to an int by "priming" Y : (X + Y / 2) / Y
    if [[ "$metadata_size" -lt 1 ]]
    then
        metadata_size=1 # % we reserve at least 1G for metadata
    fi

    if [[ "$metadata" == "no" ]] # If YunoHost is installed on BTRFS, we keep the metadata
    then
        echo "No Metadata partition was provided or we are in a container, we keep all partitions as is"
    # if [[ "$metadata" == "no" ]] && metadata_is_btrfs   # If YunoHost is installed on BTRFS, we keep the metadata
    # then
    #     echo "No Metadata partition was provided and Metadata is already on BTRFS partition"
    # # If we're NOT inside a container and the user did not provide a Metadata partition
    # elif ! $app_install_inside_container && [[ "$metadata" == "no" ]]
    # then
    #     ynh_print_warn "Creating garage_metadata.qcow2 may take time regarding disk size..."
        
    #     # We need a robust filesystem with checksuming for the Metadata, e.g. BTRFS 
    #     qemu-img create -f qcow2 $data_dir/garage_metadata.qcow2 "$metadata_size"G
    #     mount_disk "btrfs"
    #     umount_disk
    # If we're NOT inside a container and the user did provide a Metadata partition
    elif ! $app_install_inside_container
    then
        ynh_print_info "Mounting Garage MetaData with systemd..."
        #mkdir -p $data_dir/metadata # /home/yunohost.app/garage/metadata
        mkfs.btrfs -L metadata_btrfs -m crc=1 "$metadata"
        # Get UUID of new partition
        metadata_uuid=$(blkid -s UUID -o value "$metadata")
        # Edit `/etc/fstab` to auto-mount Garage Metadata `$data_dir/metadata` on new partition
        echo "# mount SSD part $metadata with btrfs filesystem for garage" | tee -a /etc/fstab
        echo "UUID=$metadata_uuid $data_dir/metadata btrfs defaults 0 0" | tee -a /etc/fstab
        # Mount Garage Metadata `$data_dir/metadata` on new partition
        ynh_config_add_systemd --mount="$app""_metadata" --template=metadata.mount
        yunohost service add garage_metadata_mounted --description="Garage MetaData Mounted" --log="/var/log/$app/$app.log"
        ynh_systemctl --service=garage_metadata_mounted --action="start" # --wait_until="Started Garage: MetaData Mount"
    # else we are in a container, we keep all partitions as is
    #mkdir -p $data_dir/metadata # /home/yunohost.app/garage/metadata
    fi
}

mount_disk() {
    # If we're NOT inside a container
    if ! $app_install_inside_container
    then
        format=$1
        i=0
        while fdisk -l /dev/nbd$i  1> /dev/null 2> /dev/null
        do
            i=$(( i + 1 ))
        done
        echo $i > $data_dir/nbd_index
        modprobe nbd max_part=$(( i + 1 ))
        if [[ "$format" = "ext4" ]]
        then
            qemu-nbd --connect /dev/nbd$i $data_dir/garage_data.qcow2
            echo "formatting /dev/nbd$i"
            mkfs.ext4 /dev/nbd$i
            mount /dev/nbd$i $data_dir/data/
            data_uuid=$(blkid -s UUID -o value "/dev/nbd$i")
        elif [[ "$format" = "xfs" ]]
        then
            qemu-nbd --connect /dev/nbd$i $data_dir/garage_data.qcow2
            echo "formatting /dev/nbd$i"
            mkfs.xfs /dev/nbd$i
            mount /dev/nbd$i $data_dir/data/
            data_uuid=$(blkid -s UUID -o value "/dev/nbd$i")
        elif [[ "$format" = "btrfs" ]]
        then
            qemu-nbd --connect /dev/nbd$i $data_dir/garage_metadata.qcow2
            echo "formatting /dev/nbd$i"
            mkfs.btrfs /dev/nbd$i
            mount /dev/nbd$i $data_dir/metadata/
            metadata_uuid=$(blkid -s UUID -o value "/dev/nbd$i")
        else
            qemu-nbd --connect /dev/nbd$i $data_dir/garage_data.qcow2
            mount /dev/nbd$i $data_dir/data/
            metadata_uuid=$(blkid -s UUID -o value "/dev/nbd$i")
        fi
    else
        ynh_die "Cannot mount_disk qcow as we are in a container"
    fi
}

umount_disk() {
    # If we're NOT inside a container
    if ! $app_install_inside_container
    then
        nbd=$(cat $data_dir/nbd_index)
        umount  /dev/nbd$nbd
        qemu-nbd --disconnect  /dev/nbd$nbd
    fi
}