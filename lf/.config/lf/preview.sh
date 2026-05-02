# #!/bin/sh
#
# UEB_PID=$(pgrep -n ueberzug)
#
# [ -z "$UEB_PID" ] && exit 1
#
# case "$(file -Lb --mime-type -- "$1")" in
#     image/*)
#         printf '{"action":"add","identifier":"img","path":"%s","x":0,"y":0,"width":40,"height":20}\n' "$1"
#         ;;
#     *)
#         cat "$1"
#         ;;
# esac
# case "$(printf "%s\n" "$(readlink -f "$1")" | tr '[:upper:]' '[:lower:]')" in
#     image/*)
#         echo "hi I'm an image"
#         ;;
#     *)
#         batcat --theme="Visual Studio Dark+" -p --color=always  "$1"
#         ;;
# esac
# exit 0
