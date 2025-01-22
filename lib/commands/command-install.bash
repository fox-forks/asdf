# -*- sh -*-
# shellcheck source=lib/functions/versions.bash
. "${0%/*/*}/lib/functions/versions.bash"
# shellcheck source=lib/commands/reshim.bash
. "${ASDF_CMD_FILE%/*}/reshim.bash"
# shellcheck source=lib/functions/installs.bash
. "${0%/*/*}/lib/functions/installs.bash"

install_command "$@"
