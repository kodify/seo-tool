# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box     = "centos6"
  config.vm.box_url = "https://s3.amazonaws.com/itmat-public/centos-6.3-chef-10.14.2.box"

  config.vm.share_folder "public", "/var/www/seo-tool/current", "."

  #config.vm.provision :shell, :path => "install-rvm.sh",  :args => "stable"
  #config.vm.provision :shell, :path => "install-ruby.sh", :args => "2.0.0"

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = 'chef/cookbooks'

    chef.add_recipe "git"
    chef.add_recipe "build-essential"
    chef.add_recipe "nodejs"
    chef.add_recipe "openssl"
    chef.add_recipe "mysql"
    chef.add_recipe "mysql::server"

    chef.add_recipe "rvm::vagrant"
    chef.add_recipe "rvm::system"

    chef.json = {
      "mysql" => {
        "server_root_password" => "",
        "server_repl_password" => "",
        "server_debian_password" => ""
      },
      :rvm => {
        :rubies => [
          "2.0.0"
        ],
        :default_ruby => "ruby-2.0.0-p247",
        :user_default_ruby => "ruby-2.0.0-p247",
        'vagrant' => {
          'system_chef_solo' => '/usr/bin/chef-solo'
        }
      }
    }


  end
end

Vagrant.configure("2") do |config|
  config.vm.network "forwarded_port", guest: 3000, host: 3000
end