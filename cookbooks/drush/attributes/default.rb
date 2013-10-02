#
# Author:: Marius Ducea (marius@promethost.com)
# Cookbook Name:: drupal
# Attributes:: drupal
#
# Copyright 2010, Promet Solutions
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
::Chef::Node.send(:include, Opscode::OpenSSL::Password)

set_unless[:drupal][:db][:password] = secure_password
default[:drush][:src] = Chef::Config[:file_cache_path]
default[:drush][:version] = "7.0-dev"

default[:drush][:url] = "https://github.com/drush-ops/drush/archive/master.zip"
default[:drush][:checksum] = "86bf384f5d70793a6f41d0e4a0d25fa1dceaccb17c9f7db1c5bf0397be6ab64a"
default[:drush][:dir] = "/usr/local/drush"

default[:drupal][:modules] = ["views", "webform"]

