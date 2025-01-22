# -*- sh -*-

plugin_push_command() {
  local plugin_name=$1
  if [ "$plugin_name" = "--all" ]; then
    for dir in "$ASDF_DATA_DIR"/plugins/*/; do
      local dirname=${dir%/}
      dirname=${dirname##*/}
      printf "Pushing %s...\n" "$dirname"
      (cd "$dir" && git push)
    done
  else
    get_plugin_path "$plugin_name"
    local plugin_path=$REPLY
    check_if_plugin_exists "$plugin_name"
    printf "Pushing %s...\n" "$plugin_name"
    (cd "$plugin_path" && git push)
  fi
}

plugin_push_command "$@"
