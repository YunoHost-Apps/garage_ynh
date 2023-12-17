#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

GARAGE_VERSION="0.9.0"

if systemd-detect-virt  -c -q
then
    system_is_inside_container="true"
    # used to comment systemd isolation to allow mount disk
    comment_if_system_is_inside_container="#"
else
    system_is_inside_container="false"
    comment_if_system_is_inside_container=""
fi

#=================================================
# PERSONAL HELPERS
#=================================================

garage_connect() {
  local command="$1"
  local peer="$2" 
  # connect to cluster
  $command node connect "$peer"
  sleep 2
  # wait until layout is updated
  local i=0
  until $command layout show 2>/dev/null | grep "${peer:0:15}"; do
    i=$(( i + 1 ))
    if [ $i -gt 30 ] 
    then
      ynh_die --message="Unable to get layout from remote peer"
    fi
    sleep 1
  done
}


apply_layout() {
    
	garage_command=$1
	$garage_command layout show 2>/dev/null
	if [ "$($garage_command layout show | grep 'This new layout cannot yet be applied')" ]
	then
        ynh_print_warn --message="Unable to apply layout. No enough nodes"
		return 0
	else
		local layout_version=$($garage_command layout show 2>/dev/null | grep -Po -- "(?<=--version).*" | head -1 | xargs)
		$garage_command layout apply --version $layout_version
	fi
}

#=================================================
# EXPERIMENTAL HELPERS
#=================================================

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
