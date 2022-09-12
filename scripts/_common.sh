#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================
pkg_dependencies="qemu-utils"

#=================================================
# PERSONAL HELPERS
#=================================================


GARAGE_VERSION="0.7.2.1"

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
  wget https://garagehq.deuxfleurs.fr/_releases/v$GARAGE_VERSION/$arch-unknown-linux-musl/garage -O "$app" 2>&1 >/dev/null
    chmod +x "$app"
  fi
}

init_garage() {
garage_command="$1"
node_id="$2"
weight="$3"
zone="$4"

$garage_command layout assign $node_id -z $zone -c $weight -t $zone

apply_layout "$garage_command"
}

apply_layout() {
	$garage_command=$1
	$garage_command -c garage.toml layout show 2>/dev/null | grep "--version"
	if [ $? -eq 0 ] 
	then
		layout_version=$($garage_command layout show 2>/dev/null | grep -Po -- "(?<=--version).*" | head -1 | xargs)
		$garage_command layout apply --version $layout_version
	else
		return 1
	fi
}
#=================================================
# EXPERIMENTAL HELPERS
#=================================================

# Send an email to inform the administrator
#
# usage: ynh_send_readme_to_admin --app_message=app_message [--recipients=recipients] [--type=type]
# | arg: -m --app_message= - The file with the content to send to the administrator.
# | arg: -r, --recipients= - The recipients of this email. Use spaces to separate multiples recipients. - default: root
#	example: "root admin@domain"
#	If you give the name of a YunoHost user, ynh_send_readme_to_admin will find its email adress for you
#	example: "root admin@domain user1 user2"
# | arg: -t, --type= - Type of mail, could be 'backup', 'change_url', 'install', 'remove', 'restore', 'upgrade'
#
# Requires YunoHost version 4.1.0 or higher.
ynh_send_readme_to_admin() {
	# Declare an array to define the options of this helper.
	declare -Ar args_array=( [m]=app_message= [r]=recipients= [t]=type= )
	local app_message
	local recipients
	local type
	# Manage arguments with getopts

	ynh_handle_getopts_args "$@"
	app_message="${app_message:-}"
	recipients="${recipients:-root}"
	type="${type:-install}"

	# Get the value of admin_mail_html
	admin_mail_html=$(ynh_app_setting_get $app admin_mail_html)
	admin_mail_html="${admin_mail_html:-0}"

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

	# Subject base
	local mail_subject="☁️🆈🅽🅷☁️: \`$app\`"

	# Adapt the subject according to the type of mail required.
	if [ "$type" = "backup" ]; then
		mail_subject="$mail_subject has just been backup."
	elif [ "$type" = "change_url" ]; then
		mail_subject="$mail_subject has just been moved to a new URL!"
	elif [ "$type" = "remove" ]; then
		mail_subject="$mail_subject has just been removed!"
	elif [ "$type" = "restore" ]; then
		mail_subject="$mail_subject has just been restored!"
	elif [ "$type" = "upgrade" ]; then
		mail_subject="$mail_subject has just been upgraded!"
	else	# install
		mail_subject="$mail_subject has just been installed!"
	fi

	ynh_add_config --template="$app_message" --destination="../conf/msg_to_send"

	ynh_delete_file_checksum --file="../conf/msg_to_send"
	local mail_message="This is an automated message from your beloved YunoHost server.
Specific information for the application $app.
$(cat "../conf/msg_to_send")"

	# Store the message into a file for further modifications.
	echo "$mail_message" > mail_to_send

	# If a html email is required. Apply html tags to the message.
 	if [ "$admin_mail_html" -eq 1 ]
 	then
		# Insert 'br' tags at each ending of lines.
		ynh_replace_string "$" "<br>" mail_to_send

		# Insert starting HTML tags
		sed --in-place '1s@^@<!DOCTYPE html>\n<html>\n<head></head>\n<body>\n@' mail_to_send

		# Keep tabulations
		ynh_replace_string "  " "\&#160;\&#160;" mail_to_send
		ynh_replace_string "\t" "\&#160;\&#160;" mail_to_send

		# Insert url links tags
		ynh_replace_string "__URL_TAG1__\(.*\)__URL_TAG2__\(.*\)__URL_TAG3__" "<a href=\"\2\">\1</a>" mail_to_send

		# Insert finishing HTML tags
		echo -e "\n</body>\n</html>" >> mail_to_send

	# Otherwise, remove tags to keep a plain text.
	else
		# Remove URL tags
		ynh_replace_string "__URL_TAG[1,3]__" "" mail_to_send
		ynh_replace_string "__URL_TAG2__" ": " mail_to_send
	fi

	# Define binary to use for mail command
	if [ -e /usr/bin/bsd-mailx ]
	then
		local mail_bin=/usr/bin/bsd-mailx
	else
		local mail_bin=/usr/bin/mail.mailutils
	fi

	if [ "$admin_mail_html" -eq 1 ]
	then
		content_type="text/html"
	else
		content_type="text/plain"
	fi

	# Send the email to the recipients
	cat mail_to_send | $mail_bin -a "Content-Type: $content_type; charset=UTF-8" -s "$mail_subject" "$recipients"
}

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
