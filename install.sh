#!/bin/bash

# -e: exit on error
# -u: exit on unset variables
set -eu

# GitHub Actions 環境でない場合にのみ以下を実行
if [ -z "${GITHUB_ACTIONS:-}" ]; then
	read -r -p "Do you want to install Dotfiles? [y/N] " response
	if [[ ! "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
		echo "Dotfiles installation skipped"
		exit 0
	fi

	# zsh のインストールチェック
	if ! command -v zsh >/dev/null; then
		echo "zsh is required to run chezmoi" >&2
		exit 1
	fi
fi

if ! chezmoi="$(command -v chezmoi)"; then
	bin_dir="${HOME}/.local/bin"
	chezmoi="${bin_dir}/chezmoi"
	echo "Installing chezmoi to '${chezmoi}'" >&2
	if command -v curl >/dev/null; then
		chezmoi_install_script="$(curl -fsSL get.chezmoi.io)"
	elif command -v wget >/dev/null; then
		chezmoi_install_script="$(wget -qO- get.chezmoi.io)"
	else
		echo "To install chezmoi, you must have curl or wget installed." >&2
		exit 1
	fi
	sh -c "${chezmoi_install_script}" -- -b "${bin_dir}"
	unset chezmoi_install_script bin_dir
fi

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"

set -- init --apply --source="${script_dir}"

echo "Running 'chezmoi $*'" >&2
# exec: replace current process with chezmoi
exec "$chezmoi" "$@"
