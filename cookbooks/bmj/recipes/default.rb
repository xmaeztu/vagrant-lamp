include_recipe "drush"

package "vim"

execute "install_drupal_root" do
  command "drush dl drupal -y --drupal-project-rename='#{node[:bmj][:site_alias]}' --destination='/var/www'"
  not_if "find /var/www -maxdepth 1 | grep /var/www/#{node[:bmj][:site_alias]}"
end

s = node[:bmj][:site_name]
site = {
  :name => s, 
  :host => s, 
  #:aliases => ["#{s}.com", "dev.#{s}-static.com"]
}

# Configure the development site
web_app site[:name] do
  template "sites.conf.erb"
  server_name site[:host]
  server_aliases site[:aliases]
  docroot "/var/www/#{node[:bmj][:site_alias]}"
end

# Configure the development site
web_app 'phpmuadmin' do
  template "sites.conf.erb"
  server_name 'phpmyadmin'
  server_aliases 'phpmyadmin'
  docroot "/usr/share/phpmyadmin"
end

# Add site info in /etc/hosts
bash "info_in_etc_hosts" do
  code "echo 127.0.0.1 #{site[:host]} #{site[:aliases]} >> /etc/hosts"
end

directory "/var/www/#{node[:bmj][:site_alias]}/sites/mainline" do
  owner "nobody"
  group "nogroup"
  mode "0777"
  action :create
end

link "/var/www/#{node[:bmj][:site_alias]}/sites/#{node[:bmj][:site_alias]}" do
  to "/var/www/#{node[:bmj][:site_alias]}/sites/mainline"
end

link "/var/www/#{node[:bmj][:site_alias]}/sites/#{node[:bmj][:site_name]}" do
  to "/var/www/#{node[:bmj][:site_alias]}/sites/mainline"
end

execute "create-db" do
  command "/usr/bin/mysqladmin -u root -p#{node[:mysql][:server_root_password]} create #{node[:bmj][:db_name]}"
  not_if "/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} -r -N -e \"SHOW databases;\" | grep #{node[:bmj][:db_name]}"
end

execute "import-db" do
  command "/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} #{node[:bmj][:db_name]} < /vagrant/#{node[:bmj][:db_name]}.sql"
  not_if "/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} -D #{node[:bmj][:db_name]} -r -N -e \"SELECT COUNT(*) FROM system;\""
end