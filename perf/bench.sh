#!/usr/bin/env bash
set -eo pipefail

die() {
	printf "%s\n" "$1"
	exit "${2:-1}" # default exit status 1
}

get_env() {
	source "$ASDF_DIR/asdf.sh"

	asdf shell nodejs 21.6.2
	asdf shell elixir 1.16.1-otp-26
	asdf shell golang 1.22.0
	asdf shell deno 1.40.5
	asdf shell crystal 1.11.2
	asdf shell kubectl 1.29.2
	asdf shell nim 2.0.2
	asdf shell rust 1.76.0
	asdf shell zig 0.11.0
	asdf shell boundary 0.15.0+ent
	asdf shell terraform 1.7.3
	asdf shell packer 1.10.1
	asdf shell nomad 1.7.5+ent
	asdf shell vault 1.15.5+ent
	asdf shell waypoint 0.11.4
}

profile() {
	local command="$1"
	local stat_file="$2"

	warmup='--warmup 10'
	if [[ "$stat_file" == *bats* ]]; then
		warmup=
	fi

	mkdir -p "${stat_file%/*}"
	hyperfine $warmup --shell none --export-json "$stat_file" "$command"
}

profile_all() {
	for filename in "${!BENCHMARKED_COMMANDS[@]}"; do
		command=${BENCHMARKED_COMMANDS[$filename]}
		profile "$command" "$filename.json" || :
	done
	touch 'done'
}

generate_stats() {
	echo "Generating graph data..."
	mkdir -p stats
	for filename in "${!BENCHMARKED_COMMANDS[@]}"; do
		command=${BENCHMARKED_COMMANDS[$filename]}

		> "stats/$filename.data"
		for stat_file in ./patches/*/"${filename#./}.json"; do
			local stat_{mean,average}=
			stat_mean=$(jq '.results[0].mean' < "$stat_file")
			stat_median=$(jq '.results[0].median' < "$stat_file")
			stat_stddev=$(jq '.results[0].stddev' < "$stat_file")
			stat_min=$(jq '.results[0].min' < "$stat_file")
			stat_max=$(jq '.results[0].max' < "$stat_file")
			printf -v stat_mean "%.*f" 3 "$stat_mean"
			printf -v stat_median "%.*f" 3 "$stat_median"
			printf -v stat_stddev "%.*f" 3 "$stat_stddev"
			printf -v stat_min "%.*f" 3 "$stat_min"
			printf -v stat_max "%.*f" 3 "$stat_max"

			column_name=${stat_file%/*}
			column_name=${column_name##*/}
			printf '%s			%s			%s			%s			%s			%s\n' "$column_name" "$stat_mean" "$stat_median" "$stat_stddev" "$stat_min" "$stat_max" >> "stats/$filename.data"
		done

		gnuplot -d -e "filename='./stats/$filename.data'" -e "command='$command'" -c ./plot.cfg
	done

}

cmd.install() {
	if [ ! -d "$ASDF_DIR" ]; then
		git clone https://github.com/asdf-vm/asdf.git "$ASDF_DIR"
	fi
	source "$ASDF_DIR/asdf.sh"

	mkdir -p "$ASDF_DATA_DIR"
	asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
	asdf plugin add elixir https://github.com/asdf-vm/asdf-elixir.git
	asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
	asdf plugin add deno https://github.com/asdf-community/asdf-deno.git
	asdf plugin add crystal https://github.com/asdf-community/asdf-crystal.git
	asdf plugin add kubectl https://github.com/asdf-community/asdf-kubectl.git
	asdf plugin add nim https://github.com/asdf-community/asdf-nim.git
	asdf plugin add rust https://github.com/asdf-community/asdf-rust.git
	asdf plugin add zig https://github.com/asdf-community/asdf-zig.git
	asdf plugin-add boundary https://github.com/asdf-community/asdf-hashicorp.git
	asdf plugin-add terraform https://github.com/asdf-community/asdf-hashicorp.git
	asdf plugin-add packer https://github.com/asdf-community/asdf-hashicorp.git
	asdf plugin-add nomad https://github.com/asdf-community/asdf-hashicorp.git
	asdf plugin-add vault https://github.com/asdf-community/asdf-hashicorp.git
	asdf plugin-add waypoint https://github.com/asdf-community/asdf-hashicorp.git

	asdf install nodejs 21.6.2
	asdf install nodejs 20.11.1
	asdf install nodejs 18.19.1
	asdf install nodejs 21.6.1
	asdf install nodejs 21.6.0
	asdf install nodejs 20.11.0
	asdf install nodejs 21.5.0
	asdf install nodejs 21.4.0
	asdf install nodejs 21.3.0
	asdf install nodejs 18.19.0
	asdf install elixir 1.16.1-otp-26
	asdf install golang 1.22.0
	asdf install deno 1.40.5
	asdf install crystal 1.11.2
	asdf install kubectl 1.29.2
	asdf install nim 2.0.2
	asdf install rust 1.76.0
	asdf install zig 0.11.0
	asdf install boundary 0.15.0+ent
	asdf install terraform 1.7.3
	asdf install packer 1.10.1
	asdf install nomad 1.7.5+ent
	asdf install vault 1.15.5+ent
	asdf install waypoint 0.11.4
}

cmd.with_bigpicture() {
	git -C "$ASDF_DIR" checkout ccdd47df9b73d0a22235eb06ad4c48eb573608321
	get_env

	printf '# %s			%s			%s			%s			%s			%s\n' 'Tag' 'Mean' 'Median' 'Stddev' 'Min' 'Max' >> "output/$slug/plot.data"
	for tag in v0.6.3 v0.8.1 v0.9.0 v0.10.0 v0.13.1 hyperupcall-perf; do
		git -C asdf checkout "$tag"
		echo "==== Checked out $tag. Benchmarking commands..."

		sed -i '/hyperupcall-perf/d' ./output/asdf-current/plot.data
		profile "$tag" 'asdf current' "./output/$slug/$tag.json" "output/$slug/plot.data" || :
	done
}

cmd.with_patches() {
	declare -A BENCHMARKED_COMMANDS=(
		['./bats-test']="$HOME/git/bats-core/bin/bats "$ASDF_DIR/test" --print-output-on-failure"
		['./asdf-current']='asdf current'
		['./asdf-which-node']='asdf which node'
		['./asdf-where-node']='asdf where nodejs'
		['./asdf-exec-node']='asdf exec node -v'
		['./asdf-reshim']='asdf reshim'
		['./asdf-list-all-node']='asdf list all nodejs'
	)

	get_env
	git -C "$ASDF_DIR" switch --quiet master
	git -C "$ASDF_DIR" branch -D hyperupcall-patch-perf || :
	git -C "$ASDF_DIR" switch --quiet -c hyperupcall-patch-perf ccdd47df9b73d0a22235eb06ad4c48eb57360832

	git -C "$ASDF_DIR" checkout HEAD lib/** bin/** test/** scripts/** completions/**
	cd patches

	echo "RUNNING: ----- 00"
	pushd ./00-* >/dev/null
	if [ ! -f 'done' ]; then
		git diff --shortstat
		profile_all
	fi
	popd >/dev/null

	echo "RUNNING: ----- 01"
	pushd ./01-* >/dev/null
	git -C "$ASDF_DIR" apply "$PWD/4.patch"
	if [ ! -f 'done' ]; then
		git diff --shortstat
		profile_all
	fi
	popd >/dev/null

	echo "RUNNING: ----- 02"
	pushd ./02-* >/dev/null
	git -C "$ASDF_DIR" checkout HEAD lib/** bin/** test/** scripts/** completions/**
	git -C "$ASDF_DIR" apply "$PWD/7.patch"
	if [ ! -f 'done' ]; then
		git diff --shortstat
		profile_all
	fi
	popd >/dev/null

	echo "RUNNING: ----- 03"
	pushd ./03-* >/dev/null
	git -C "$ASDF_DIR" checkout HEAD lib/** bin/** test/** scripts/** completions/**
	git -C "$ASDF_DIR" apply "$PWD/1.patch"
	if [ ! -f 'done' ]; then
		git diff --shortstat
		profile_all
	fi
	popd >/dev/null

	cd ..
	generate_stats
	montage -tile 2x0 -geometry +5+50 ./stats/*.png final.png
	sxiv final.png
}

cmd.apply_patches() {
	git -C "$ASDF_DIR" checkout HEAD lib/** bin/** test/** scripts/** completions/**
	git -C "$ASDF_DIR" apply ./perf/patches/01-pathname-subshells/4.patch
	git -C "$ASDF_DIR" apply ./perf/patches/02-vars-subshells/7.patch
}

cmd.exec() {
	source "$ASDF_DIR/asdf.sh"
	"$@"
}

cd "${0%/*}"
export ASDF_DIR="$PWD/.."
export ASDF_CONFIG_FILE="$PWD/asdf_data_dir/asdfrc"
export ASDF_DATA_DIR="$PWD/asdf_data_dir"

case $1 in
	install)
		cmd.install "${@:2}"
		;;
	with-bigpicture)
		cmd.with_bigpicture "${@:2}"
		;;
	with-patches)
		cmd.with_patches "${@:2}"
		;;
	apply-patches)
		cmd.apply_patches "${@:2}"
		;;
	exec)
		cmd.exec "${@:2}"
		;;
	*)
		die "Subcommands are either 'install', 'with-bigpicture', 'with-patches', 'apply-patches', or 'exec'"
esac
