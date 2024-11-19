#!/bin/bash

# Idea shameless copied from https://github.com/Traap/bootstrap-archlinux/blob/master/install.sh

# {{{ Notes

# -------------------------------------------------------------------------- }}}

#  {{{ Main 

main() {

	cwd=$(pwd)

	sourceFiles

	installBasePackages
	installBaseOptionalPackages
	installCommonDevPackages
	installOrganisationalPackages
	installJavaDevelopmentPackages
	installVersionControlSystemTools
	

}
# -------------------------------------------------------------------------- }}}

# {{{ Tell them what is about to happen.

say() {
  echo '********************'
  echo "${1}"
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
# {{{ Install base packages

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

