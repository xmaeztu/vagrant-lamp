Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. For a detailed explanation
  # and listing of configuration options, please view the documentation
  # online.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "base"
  #config.vm.box_url = "http://files.vagrantup.com/lucid32.box"

  #config.vm.provision :shell, :path => "vagrant-setup.sh"
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe("vagrant_main")
    chef.add_recipe("drush")
    chef.json.merge!({
    :mysql => {
      :server_root_password => "root"
    }
  })
  end

  config.vm.forward_port(80, 8080)

end
