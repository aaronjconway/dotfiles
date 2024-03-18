#!/usr/bin/env zsh

typeset -g FILE_PATH="$1"
typeset -g PREVIEW_WIDTH="$2"
typeset -g PREVIEW_HEIGHT="$3"
typeset -g PREVIEW_POSITION_X="$4"
typeset -g PREVIEW_POSITION_Y="$5"
typeset -g FILE_MIMETYPE="$(file --dereference --brief --mime-type -- "${FILE_PATH}")"

function handle_preview() {
     batcat "${FILE_PATH}" ;;
  }
}

function main() {
  # Print MIME type.
  printf '%s: %s\n\n' \
    "$FILE_MIMETYPE" \
    "$(file --dereference --brief -- ${FILE_PATH})"

  # Skip files over 10MB but only within previewer.
  local file_size=$(stat --printf='%s' -- "${FILE_PATH}")
  if ([[ "$PREVIEW_WIDTH" != '' ]] && (( $file_size > 10000000 ))) {
    return 1
  }

  # Show additional EXIF data inside `less` only.
  if ([[ "$PREVIEW_WIDTH" == '' ]]) {
    exiftool "${FILE_PATH}"
    printf '\n'
  }

  # Show preview of the file.
  handle_preview
}

main
