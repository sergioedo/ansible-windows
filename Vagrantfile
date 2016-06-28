# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.synced_folder "c:/src/ansible-windows", "/src"
  config.vm.network "forwarded_port", guest: 5986, host: 5986  
  
  config.vm.provider "virtualbox" do |vb|
    vb.name = "ansible-manager-test"
    vb.memory = "1024"
  end
  
  config.vm.provision :shell, path: "bootstrap-ansible.sh"
end
