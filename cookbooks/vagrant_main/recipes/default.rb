include_recipe "apt"
include_recipe "apache2"
include_recipe "mysql::server"
include_recipe "php::php5"
include_recipe "drush"

# get phpmyadmin conf
cookbook_file "/tmp/phpmyadmin.deb.conf" do
  source "phpmyadmin.deb.conf"
end

bash "debconf_for_phpmyadmin" do
  code "debconf-set-selections /tmp/phpmyadmin.deb.conf"
end

package "phpmyadmin"

execute "install_drupal_root" do
  command "drush dl drupal -y --drupal-project-rename='drupal#{node[:vagrant_main][:drupal_version]}' --destination='/vagrant'"
  not_if "find /vagrant -maxdepth 1 | grep /vagrant/drupal#{node[:vagrant_main][:drupal_version]}"
end

#s = node[:vagrant_main][:site_name]
#site = {
#  :name => s, 
#  :host => s, 
#  #:aliases => ["#{s}.com", "dev.#{s}-static.com"]
#}
#
## Configure the development site
#web_app site[:name] do
#  template "sites.conf.erb"
#  server_name site[:host]
#  server_aliases site[:aliases]
#  docroot "/vagrant/#{node[:vagrant_main][:site_alias]}"
#end  
#
## Add site info in /etc/hosts
#bash "info_in_etc_hosts" do
#  code "echo 127.0.0.1 #{site[:host]} #{site[:aliases]} >> /etc/hosts"
#end
#
#
## Add an admin user to mysql
#execute "add-admin-user" do
#  command "/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} -e \"" +
#      "CREATE USER 'myadmin'@'localhost' IDENTIFIED BY 'myadmin';" +
#      "GRANT ALL PRIVILEGES ON *.* TO 'myadmin'@'localhost' WITH GRANT OPTION;" +
#      "CREATE USER 'myadmin'@'%' IDENTIFIED BY 'myadmin';" +
#      "GRANT ALL PRIVILEGES ON *.* TO 'myadmin'@'%' WITH GRANT OPTION;\" " +
#      "mysql"
#  action :run
#  only_if { `/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} -D mysql -r -N -e \"SELECT COUNT(*) FROM user where user='myadmin' and host='localhost'"`.to_i == 0 }
#  ignore_failure true
#end