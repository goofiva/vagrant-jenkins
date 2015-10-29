# -*- mode: ruby -*-
# vim: set ft=ruby expandtab ts=4 sw=4:

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

#-----------------------------------------------------------------------------------------------------------------------
# Local Development VM Configuration
#-----------------------------------------------------------------------------------------------------------------------
  config.vm.define :jenkins do |config|
    config.omnibus.chef_version = '12.5.1'
    config.vm.box = 'ubuntu-15.04-amd64'
    config.vm.box_url = 'https://github.com/kraksoft/vagrant-box-ubuntu/releases/download/15.04/ubuntu-15.04-amd64.box'
    config.vm.hostname = 'jenkins'
    config.vm.boot_timeout = 600
    config.vm.network :private_network, :ip => '10.10.10.20'
    config.vm.network :forwarded_port, guest: 8080, host: 8080, id: "jenkins", auto_correct: true

    config.berkshelf.enabled = true
    config.berkshelf.berksfile_path = 'Berksfile'

    config.vm.provider "virtualbox" do |v|
      v.memory = 4096
      v.name = 'jenkins'

      v.customize ['modifyvm', :id, '--cpuexecutioncap', '100']
      v.customize ['modifyvm', :id, '--cpuhotplug', 'on']
      v.customize ['modifyvm', :id, '--cpus', 2]
    end

    config.vm.provision :chef_solo do |chef|
      chef.node_name = "jenkins-01"
      chef.environment = 'dev'
      chef.provisioning_path = '/etc/chef'
      # chef.encrypted_data_bag_secret_key_path = "#{ENV["HOME"]}/.ssh/databag_secret.pem"
      # chef.cookbooks_path = %w(
      #     ./ops/chef/cookbooks/community
      #     ./ops/chef/cookbooks/custom
      #     ./ops/chef/cookbooks/services)
      # chef.data_bags_path = ["./ops/chef/data_bags"]
      chef.roles_path = ["./ops/chef/roles"]
      chef.environments_path = ["./ops/chef/environments"]
      # chef.json = JSON.parse(File.read('chef.local.json'))

	    chef.add_recipe 'vagrant_jenkins::setup'
    end
  end

end