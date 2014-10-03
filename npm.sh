#!/usr/bin/env bash

if [ ! -d "${HOME}/.npm-packages" ] ; then
	echo 'NPM_PACKAGES="${HOME}/.npm-packages"' >> ${HOME}/.bash_profile
	echo 'PATH=${PATH}:${NPM_PACKAGES}/bin' >> ${HOME}/.bash_profile
	echo 'NODE_PATH="${NPM_PACKAGES}/lib/node_modules:${NODE_PATH}"' >> ${HOME}/.bash_profile
	echo 'prefix=${HOME}/.npm-packages' >> ${HOME}/.npmrc
	echo 'MANPATH="$NPM_PACKAGES/share/man:$(manpath)"' >> ${HOME}/.bash_profile

	npm install -g grunt-cli bower yo cordova
fi