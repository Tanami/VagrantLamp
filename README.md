# VagrantLamp
Vagrant Lamp stack for project work

Requirements
------------
* VirtualBox <http://www.virtualbox.com>
* Vagrant <http://www.vagrantup.com>
* Vagrant plugin - Hostmanager <https://github.com/smdahlen/vagrant-hostmanager>

Usage
-----
### Create Project
  	$ mkdir PROJECTNAME && cd PROJECTNAME
  	$ git clone https://github.com/AdamJHall/VagrantLamp.git .
  	$ PROJECT=yourprojectname vagrant up

You may also need to run "$ PROJECT=yourprojectname vagrant hostmanager" to update your hosts file

### Connecting
	$ vagrant ssh

A folder named yourprojectname will be created, add any php code to it and it will be available at 
yourprojectname.com