#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

#=================================================
# PERSONAL HELPERS
#=================================================

systemd-detect-virt  -c -q
if [ $? ] 
then #system is inside a container, 
    export VIRTUALISATION=true
    virtualisation=true
    # comment systemd isolation to allow mount disk
    virt_protection="#"
else
    virtualisation=false
    export VIRTUALISATION=false
    # uncomment systemd isolation
    virt_protection=""
fi
    

GARAGE_VERSION="0.8.2"

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
      ynh_die --message="unable to get layout from remote peer"
    fi
    sleep 1
  done
}


apply_layout() {
    
	garage_command=$1
	$garage_command layout show 2>/dev/null
	local layout_version=$($garage_command layout show 2>/dev/null | grep -Po -- "(?<=--version).*" | head -1 | xargs)
	if [ "$layout_version" != ""  ] 
	then
		$garage_command layout apply --version $layout_version
	else
        ynh_print_warn --message="unable to apply layout. No enough nodes"
		return 0
	fi
}
#=================================================
# EXPERIMENTAL HELPERS
#=================================================

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
