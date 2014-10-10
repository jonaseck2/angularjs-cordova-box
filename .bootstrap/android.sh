#!/usr/bin/env bash

if [ ! -d "${HOME}/android-sdk-linux/" ] ; then
	
	sudo apt-get -y install openjdk-7-jdk ant expect unzip

	android_sdk="android-sdk_r23.0.2-linux.tgz"
	android_sdk_url="http://dl.google.com/android/${android_sdk}"
	intel_image="sysimg_x86-19_r01.zip"
	intel_image_url="http://download-software.intel.com/sites/landingpage/android/${intel_image}"
	android_device="Nexus S"

	echo 'export ANDROID_SDK_HOME=/vagrant/.android' >> ${HOME}/.bash_profile
	echo "export ANDROID_HOME=${HOME}/android-sdk-linux" >> ${HOME}/.bash_profile
	echo 'export PATH=${PATH}:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools' >> ${HOME}/.bash_profile
	echo 'export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-i386' >> ${HOME}/.bash_profile
	
	source ${HOME}/.bash_profile

	mkdir -vp ${ANDROID_SDK_HOME}
	mkdir -vp /vagrant/.download/
	if [ ! -f "/vagrant/.download/${android_sdk}" ] ; then
		echo "downloading ${android_sdk_url}"
		wget --quiet "${android_sdk_url}" -P /vagrant/.download/
	fi

	tar -xvzf /vagrant/.download/${android_sdk}

	expect -c '
	set timeout -1   ;
	spawn android update sdk -u --all --filter platform-tool,android-19,build-tools-19.1.0
	expect { 
    	"Do you accept the license" { exp_send "y\r" ; exp_continue }
    	eof
	}
	'

	#download intel x86 android image api level 19
	if [ ! -f "/vagrant/.download/${intel_image}" ] ; then
		echo "downloading ${intel_image_url}"
		wget --quiet intel_image_url -P /vagrant/.download/
	fi

	mkdir -vp ${ANDROID_HOME}/system-images/android-19/default/
	unzip -o /vagrant/.download/${intel_image} -d ${ANDROID_HOME}/system-images/android-19/default/

	if [ `android list avd | wc -l` -le 1 ] ; then
		android -s create avd -n default-19 -t android-19 -b default/x86 -d "${android_device}"
	fi
fi
