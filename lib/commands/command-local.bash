# -*- sh -*-

# shellcheck source=lib/commands/version_commands.bash
. "${ASDF_CMD_FILE%/*}/version_commands.bash"

local_command "$@"
