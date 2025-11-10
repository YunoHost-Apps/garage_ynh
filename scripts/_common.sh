#!/bin/bash

#=================================================
# COMMON VARIABLES AND CUSTOM HELPERS
#=================================================

GARAGE_VERSION="2.0.0"

metadata_is_btrfs() {
    df -Th $data_dir/metadata | grep -q "btrfs"
}

system_is_inside_container() {
    systemd-detect-virt  -c -q
}

if system_is_inside_container
then
    # used to comment systemd isolation to allow mount disk
    system_is_inside_container_bool="true"
    comment_if_system_is_inside_container="#"
else
    system_is_inside_container_bool="false"
    comment_if_system_is_inside_container=""
fi

garage="$install_dir/garage -c $install_dir/garage.toml"

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

mount_disk() {
  # If we're NOT inside a container
  if ! systemd-detect-virt -c -q
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
      if [[ "$format" = "ext4" ]]
      then
          qemu-nbd --connect /dev/nbd$i $data_dir/garage_data.qcow2
          echo "formatting /dev/nbd$i"
          mkfs.ext4 /dev/nbd$i
          #mkdir -p $data_dir/data
          chown  __APP__:__APP__  $data_dir/data
          mount /dev/nbd$i $data_dir/data/
      elif [[ "$format" = "xfs" ]]
      then
          qemu-nbd --connect /dev/nbd$i $data_dir/garage_data.qcow2
          echo "formatting /dev/nbd$i"
          mkfs.xfs /dev/nbd$i
          #mkdir -p $data_dir/data
          chown  __APP__:__APP__  $data_dir/data
          mount /dev/nbd$i $data_dir/data/
      elif [[ "$format" = "btrfs" ]]
      then
          qemu-nbd --connect /dev/nbd$i $data_dir/garage_metadata.qcow2
          echo "formatting /dev/nbd$i"
          mkfs.btrfs /dev/nbd$i
          #mkdir -p $data_dir/metadata
          chown  __APP__:__APP__  $data_dir/metadata
          mount /dev/nbd$i $data_dir/metadata/
      fi
  fi
}

umount_disk() {
  # If we're NOT inside a container
  if ! systemd-detect-virt -c -q
  then
      data_dir=__DATA_DIR__
      nbd=$(cat $data_dir/nbd_index)
      umount  /dev/nbd$nbd
      qemu-nbd --disconnect  /dev/nbd$nbd
  fi
}