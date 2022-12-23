#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================
pkg_dependencies_virtualisation="qemu-utils e2fsprogs"

#=================================================
# PERSONAL HELPERS
#=================================================


GARAGE_VERSION="0.8.0"

get_ip() {
  curl ip.me
}
# inspired by restic helper
install_garage () {
  architecture=$(uname -m)
  arch=''
  case $architecture in
    i386|i686)
      arch="i686"
      ;;
    x86_64)
      arch=x86_64
      ;;
    armv*)
      arch=armv6l
      ;;
    aarch64)
      arch=aarch64
      ;;
    *)
      echo
      ynh_die --message="Unsupported architecture \"$architecture\""
      ;;
  esac
  wget https://garagehq.deuxfleurs.fr/_releases/v$GARAGE_VERSION/$arch-unknown-linux-musl/garage -O garage 2>&1 >/dev/null
    chmod +x garage
}

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
      ynh_die --message="unable to get layout from remove peer"
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

ynh_send_readme_to_admin() {
    local app_message="${1:-...No specific information...}"
    local recipients="${2:-root}"

    # Retrieve the email of users
    find_mails () {
        local list_mails="$1"
        local mail
        local recipients=" "
        # Read each mail in argument
        for mail in $list_mails
        do
            # Keep root or a real email address as it is
            if [ "$mail" = "root" ] || echo "$mail" | grep --quiet "@"
            then
                recipients="$recipients $mail"
            else
                # But replace an user name without a domain after by its email
                if mail=$(ynh_user_get_info "$mail" "mail" 2> /dev/null)
                then
                    recipients="$recipients $mail"
                fi
            fi
        done
        echo "$recipients"
    }
    recipients=$(find_mails "$recipients")

    local mail_subject="☁️🆈🅽🅷☁️: \`$app\` was just installed!"

    local mail_message="This is an automated message from your beloved YunoHost server.
Specific information for the application $app.
$app_message"

    # Define binary to use for mail command
    if [ -e /usr/bin/bsd-mailx ]
    then
        local mail_bin=/usr/bin/bsd-mailx
    else
        local mail_bin=/usr/bin/mail.mailutils
    fi

    # Send the email to the recipients
    echo "$mail_message" | $mail_bin -a "Content-Type: text/plain; charset=UTF-8" -s "$mail_subject" "$recipients"
}
#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
