# angularjs-cordova-box #

A **vagrant** box provisioned with the cordova development environment for the **android** platform. **All you have to do** is to clone the repository, fire `vagrant up` and add your android device to VirtualBox. After that you are ready to begin your cordova project.

This box is configured to work with the yeoman generator **generator-angularjs-cordova** and adds the tools required to generate a skeleton project.

## Installation ##

### 1) Download and install the box ###

1. install vagrant http://docs.vagrantup.com/v2/installation/index.html
2. run `git clone https://github.com/jonaseck2/angularjs-cordova-box.git`
3. run `cd angularjs-cordova-box`
3. run `vagrant up`

#### Note for Windows hosts:

If you're using Windows as a host, then you will have problems trying to use the shared folder to store projects. VirtualBox, NTFS, and symlinks don't work well together. To get around this issue:

1. Open the `Vagrantfile` and uncomment the line under the comment "Enable symlinks in Windows."
2. Open `secpol.msc` and navigate to `Security Settings > Local Policies > User Rights Assignment`
3. Open the `Create Symbolic Links` and add the Administrators group if it isn't already there.
4. Open your command prompt with `Run as administrator` 
5. Run `vagrant up` to create and initialize the virtual machine
6. Run `vagrant ssh` to connect and work in the machine as usual.

You must use the elevated command prompt to work with the machine. Running `vagrant up` from a non-elevated command prompt causes the machine to be unable to sync the share and see items created from the Windows side.

### 2) Configure your device on the box ###

The box doesn't have an UI, so there is no emulator, you can only install on the device. In order to do so, you need to configure the VirtualBox to see your device through a USB port:

0. Plug the device
1. VirtualBox -> angularjs-cordova-box -> Settings -> Ports -> USB -> Add Filter -> (Select your android device)
2. (your device) Settings -> Developer Options -> USB Debugging (remark if it alreday marked)
3. (your device) A prompt to allow the virtual machine will appear. Click ok.
4. Plug and unplug the USB device.
5. (vagrant) run `adb devices`. You now should see your device on the list. 

In order to resolve the `?????? no permissions` problem:

* sudo -s
* adb kill-server
* adb start-server
* adb devices

### 3) Create and run your cordova project ###

1. run `vagrant ssh`
2. run `cd /vagrant`
3. run `cordova create folder-name -n ProjectName`
4. run `cd folder-name`
5. run `cordova run android`

**That's it.**

## About ##

This box will install and configure the following:

* Vim
* Git
* Node.js
* Npm
* Java JRE
* Java SDK
* Android ADT
* Ant
* grunt-cli
* bower
* yo
* cordova

### 4) Generate and start generator-angularjs-cordova skeleton:
1. create a basic cordova project
run `cordova create HelloCordova && cd HelloCordova`
2. add android platform
run `cordova platform add android`
3. install the cordova-angularjs generator
run `npm install -g generator-angularjs-cordova`
4. Run the generator, answer the questions and wait for the project to be generated
run `yo angularjs-cordova`
5. Change the default grunt port to 0.0.0.0 to expose the port outside of the box
run `sed -i -e 's/localhost/0.0.0.0/'`
6. build the project
run `grunt build && cordova build`
7. test android emulation
run `cordova emulate android`
8. test the webapp
run `grunt serve`

TL;DR 
1. run `cordova create HelloCordova && cd HelloCordova && cordova platform add android && npm install -g generator-angularjs-cordova && yo angularjs-cordova && sed -i -e 's/localhost/0.0.0.0/' Gruntfile.js`
2. Answer the questions and wait for the project to be generated
3. run 'grunt build && cordova build'
4. test android emulation
run `cordova emulate android`
5. test the webapp
run `grunt serve`
