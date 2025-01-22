# -*- sh -*-

list_command() {
  local plugin_name=$1
  local query=$2

  if [ -z "$plugin_name" ]; then
    get_plugin_path
    local plugins_path=$REPLY

    for plugin_path in "$plugins_path"/*/; do
      if [ ! -d "$plugin_path" ]; then
        printf "%s\n" 'No plugins installed'
        break
      fi

      plugin_name=${plugin_path%/}
      plugin_name=${plugin_name##*/}
      printf "%s\n" "$plugin_name"
      display_installed_versions "$plugin_name" "$query"
    done
  else
    check_if_plugin_exists "$plugin_name"
    display_installed_versions "$plugin_name" "$query"
  fi
}

display_installed_versions() {
  local plugin_name=$1
  local query=$2
  local versions
  local current_version
  local flag

  versions=$(list_installed_versions "$plugin_name")

  if [[ $query ]]; then
    versions=$(printf "%s\n" "$versions" | grep -E "^\s*$query")

    if [ -z "${versions}" ]; then
      display_error "No compatible versions installed ($plugin_name $query)"
      exit 1
    fi
  fi

  if [ -n "${versions}" ]; then
    current_version=$(cut -d '|' -f 1 <<<"$(find_versions "$plugin_name" "$PWD")")

    for version in $versions; do
      flag="  "
      if [[ "$version" == "$current_version" ]]; then
        flag=" *"
      fi
      printf "%s%s\n" "$flag" "$version"
    done
  else
    display_error '  No versions installed'
  fi
}

list_command "$@"
