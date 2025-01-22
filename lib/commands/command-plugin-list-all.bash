# -*- sh -*-

plugin_list_all_command() {
  initialize_or_update_plugin_repository

  local plugins_index_path
  plugins_index_path="$ASDF_DATA_DIR/repository/plugins"

  get_plugin_path
  local plugins_local_path=$REPLY

  local child_dirs=("$plugins_index_path"/*/)
  if (( ${#child_dirs[@]} > 0 )); then
    {
      for index_plugin in "$plugins_index_path"/*; do
        index_plugin_name=$(basename "$index_plugin")
        source_url=$(get_plugin_source_url "$index_plugin_name")
        installed_flag=" "

        [[ -d "${plugins_local_path}/${index_plugin_name}" ]] && installed_flag='*'

        printf "%s\t%s\n" "$index_plugin_name" "$installed_flag$source_url"
      done
    } | awk '{ printf("%-28s", $1); sub(/^[^*]/, " &", $2); $1=""; print $0 }'
  else
    printf "%s%s\n" "error: index of plugins not found at " "$plugins_index_path"
  fi
}

plugin_list_all_command "$@"
