#!/bin/sh

batorcat() {
    file="$1"
    shift
    batcat --theme="Visual Studio Dark+" -p --color=always  "$file" "$@"
}

case "$(printf "%s\n" "$(readlink -f "$1")" | tr '[:upper:]' '[:lower:]')" in
    *)
        batorcat "$1"
        ;;
esac
exit 0
