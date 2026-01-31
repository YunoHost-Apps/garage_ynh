#!/bin/bash

#=================================================
# COMMON VARIABLES AND CUSTOM HELPERS
#=================================================

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
