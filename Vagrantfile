# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
	config.vm.box = "ubuntu/trusty64"

    #Networking
    config.hostmanager.enabled = true
	config.hostmanager.manage_host = true
	config.hostmanager.include_offline = true
	config.vm.network :private_network, ip: '192.168.42.42'

    #Synced Folders and Provisioning
    if ENV.has_key?("PROJECT")
        hostname= ENV["PROJECT"] + ".com"
        config.vm.hostname = "www." + #{hostname}"
        config.hostmanager.aliases="#{hostname}"
        config.vm.synced_folder "./" + ENV["PROJECT"] + "/", "/var/www/" + ENV["PROJECT"] + "/", create: true, group: "www-data", owner: "www-data"

        config.vm.provision "shell" do |s|
            s.path = "./provision.sh"
            s.args   = "#{ENV['PROJECT']}"
        end
    else
        config.vm.provision "shell", inline: "echo Project not set"
    end
end