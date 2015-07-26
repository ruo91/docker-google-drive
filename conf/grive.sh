#------------------------------------------------#
# Autosync for Google Drive
# Maintainer: Yongbok Kim (ruo91@yongbok.net)
#------------------------------------------------#
#!/bin/bash
GRIVE_BINARY="$(which grive)"
GRIVE_SYNC_DIR="/google-drive"
GRIVE_AUTH_FILES="$GRIVE_SYNC_DIR/.grive"
GRIVE_AUTH_JSON_FILES="/opt/google-drive.json"
CRONTAB="/etc/crontab"
CRONTAB_CHECK="$(grep Grive /etc/crontab | cut -d '#' -f 2)"

function f_auth {
  if [ -f $GRIVE_AUTH_FILES ]; then
      echo "Already auth files exists!"

  else
      if [ -f "$GRIVE_AUTH_JSON_FILES" ]; then
          cd $GRIVE_SYNC_DIR
          $GRIVE_BINARY -a $GRIVE_AUTH_JSON_FILES << EOF
          $ARG_2
EOF

          if [ "$CRONTAB_CHECK" != "Grive" ]; then
              echo "#Grive" >> $CRONTAB
              echo "*/10 * * * * root /bin/grive.sh sync" >> $CRONTAB

          else
              echo "Already crontab exists!"
          fi
 
      else
          echo "Not found json files!"
      fi
  fi
}

function f_sync {
  $GRIVE_BINARY -p $GRIVE_SYNC_DIR
}

function f_help {
  echo "Usage: $ARG_0 [Options] [Authentication code]"
  echo
  echo "- Please go to this URL and get an authentication code"
  echo "- URL to visit: https://goo.gl/Rj8OSu"
  echo
  echo "- Options"
  echo "a, auth		: Authentication"
  echo "s, sync		: Sync"
  echo
}

# Main
ARG_0="$0"
ARG_1="$1"
ARG_2="$2"

case ${ARG_1} in
    a|auth)
        f_auth
        ;;

    s|sync)
        f_sync
	;;

    *)
        f_help
	;;
esac