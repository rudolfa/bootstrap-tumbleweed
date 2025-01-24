#!/bin/bash

# Idea shameless copied from https://github.com/Traap/bootstrap-archlinux/blob/master/install.sh

# {{{ Notes

# -------------------------------------------------------------------------- }}}

#  {{{ Main 

main() {

# Root directory for git repositories which are used to customize bootstrap process
bootstrapGitRepos=$HOME/git

	cwd=$(pwd)

	installGit

	sourceFiles

#	installBasePackages
#	installBaseOptionalPackages
#	installCommonDevPackages
#	installOrganisationalPackages
#	installJavaDevelopmentPackages
#	installVersionControlSystemTools
#	
#	installSdkman

}
# -------------------------------------------------------------------------- }}}

# {{{ Tell them what is about to happen.

say() {
  echo '********************'
  echo "${1}"
}

# -------------------------------------------------------------------------- }}}

# {{{ Install git 

installGit() {
	if ! command -v git >/dev/null 2>&1; then
		echo "Git ist nicht installiert."
		sudo zypper install git
	fi
}


# -------------------------------------------------------------------------- }}}

# {{{ Clone 

cloneRepos(){

repos=(
	"bootstrap-tumbleweed"
#	"dotfiles"
#	"tmux"
#	"vim"
#	"nvim"
)

say 'Cloning my git repositories'
for repo in "$repos[@]}"
do
	src=https://github.com/rudolfa/$repo.git
	dst=$bootstrapGitRepos/$repo
	if [ ! -d $dst ]; then
		git clone "$src" "$dst"
		echo ""
	fi
done
}

# -------------------------------------------------------------------------- }}}

# {{{ Source all configuration files

sourceFiles() {
  missingFile=0

  files=(config packages)
  for f in "${files[@]}"
  do
    source "$f"
  done

  [[ $missingFile == true ]] && say 'Missing file(s) program exiting.' && exit

}

# -------------------------------------------------------------------------- }}}

# {{{ Install organisational packagaes

installOrganisationalPackages(){
	if [[ $organisationPackagesFlag == true ]]; then
		say "Install organisational packages"
		sudo zypper in "${organisation_packages[@]}"
	fi
}

# -------------------------------------------------------------------------- }}}

# {{{ Install base packageszo

installBasePackages(){
	if [[ $basePackagesFlag == true ]]; then
		say "Install base packages"
		sudo zypper in "${base_packages[@]}"
	fi
}

# -------------------------------------------------------------------------- }}}

# {{{ Install base optional packages

installBaseOptionalPackages(){
	if [[ $baseOptionalPackagesFlag == true ]]; then
		say "Install base packages"
		sudo zypper in "${base_optional_packages[@]}"
	fi
}

# -------------------------------------------------------------------------- }}}

# {{{ Install common development packages

installCommonDevPackages(){
	if [[ $commonDevPackagesFlag == true ]]; then
		say "Install common dev packages"
		sudo zypper in "${common_dev_packages[@]}"
	fi
}

# -------------------------------------------------------------------------- }}}

# {{{ Install sdkman, a software development kit manager
installSdkman(){
	if [ -n "$SDKMAN_DIR" ]; then
		echo "SDKMAN already installed ( Env variable SDKMAN_DIR in use )."
	elif command -v sdk &> /dev/null; then
		echo "SDKMAN already installed (Command sdk is available):"
	else
		echo "SDKMAN not installed"
		curl -s "https://get.sdkman.io?rcupdate=false" | bash
	fi
}

#--------------------------------------------------------------------------- }}}

# {{{ Install java development packages

installJavaDevelopmentPackages(){

if [[ $javaDevelopmentPackagesFlag == true ]]; then
		say "Install java development packages"
		sudo zypper in "${java_packages[@]}"
fi

}

# -------------------------------------------------------------------------- }}}

# {{{ Install version control packages

installVersionControlSystemTools(){

		if [[ $versionControlSystemToolsFlag == true ]]; then
				say "Install version control system tools"
				sudo zypper in "${vcs_packages[@]}"
		fi
}
# -------------------------------------------------------------------------- }}}

# {{{ The stage is set ... start the show!!!

main "$@"

# -------------------------------------------------------------------------- }}}

