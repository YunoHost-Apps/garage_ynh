#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================


#=================================================
# PERSONAL HELPERS
#=================================================


GARAGE_VERSION="0.7.2.1"

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
  else
    ynh_die --message="\nDownloaded file does not match expected sha256 sum, aborting"
  fi
}

#=================================================
# EXPERIMENTAL HELPERS
#=================================================

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
