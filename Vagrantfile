Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. For a detailed explanation
  # and listing of configuration options, please view the documentation
  # online.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  
  config.vm.synced_folder ".", "/vagrant",  :nfs => true 

  config.vm.provision :shell, :path => "vagrant-setup.sh"
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe("vagrant_main")
    chef.add_recipe("vim")
    chef.json.merge!({
    :mysql => {
      :server_root_password => "root"
    }
  })
  end
  config.vm.network :private_network, ip: "192.168.3.222"
  config.vm.network :forwarded_port, guest: 80, host: 8080

end
