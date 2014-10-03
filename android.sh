#!/usr/bin/env bash
if [ ! -d "${HOME}/android/${adt_bundle}" ] ; then
	
	adt_bundle="adt-bundle-linux-x86-20140702"
	intel_image="sysimg_x86-19_r01"
	android_device="Nexus S"

	#download android sdk
	mkdir -vp /vagrant/.download/
	if [ ! -f /vagrant/.download/${adt_bundle}.zip ] ; then
		echo "downloading http://dl.google.com/android/adt/${adt_bundle}.zip"
		wget --quiet http://dl.google.com/android/adt/${adt_bundle}.zip -P /vagrant/.download/
	fi

	mkdir -vp ${HOME}/android	
	unzip -o /vagrant/.download/${adt_bundle}.zip -d ${HOME}/android/

	echo "export ANDROID_HOME=${HOME}/android/${adt_bundle}/sdk" >> ${HOME}/.bash_profile
	echo 'export PATH=${PATH}:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools' >> ${HOME}/.bash_profile
	echo 'export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-i386' >> ${HOME}/.bash_profile
	
	source ${HOME}/.bash_profile

	echo y | android update sdk --no-ui -t android-19

	#download intel x86 android image api level 19
	if [ ! -f /vagrant/.download/${intel_image}.zip ] ; then
		echo "downloading http://download-software.intel.com/sites/landingpage/android/${intel_image}.zip"
		wget --quiet http://download-software.intel.com/sites/landingpage/android/${intel_image}.zip -P /vagrant/.download/
	fi

	mkdir -vp ${ANDROID_HOME}/system-images/android-19/default/
	unzip -o /vagrant/.download/${intel_image}.zip -d ${ANDROID_HOME}/system-images/android-19/default/

	android -s create avd -n default-19 -t android-19 -b default/x86 -d "${android_device}"
fi
