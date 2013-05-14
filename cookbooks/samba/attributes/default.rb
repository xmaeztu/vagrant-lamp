#
# Cookbook Name:: samba
# Attributes:: default
#
# Copyright 2010, Opscode, Inc.
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

default["samba"]["workgroup"] = "SAMBA"
default["samba"]["interfaces"] = "lo 127.0.0.1"
default["samba"]["hosts_allow"] = "127.0.0.0/8"
default["samba"]["bind_interfaces_only"] = "no"
#default["samba"]["server_string"] = "Samba Server"
default["samba"]["load_printers"] = "no"
default["samba"]["passdb_backend"] = "tdbsam"
default["samba"]["dns_proxy"] = "no"
default["samba"]["security"] = "share"
default["samba"]["map_to_guest"] = "Bad User"
default["samba"]["socket_options"] = "TCP_NODELAY"

default["samba"]["folder"]["name"] = "www"
default["samba"]["folder"]["comment"] = "The www folder"
default["samba"]["folder"]["path"] = "/var/www"
default["samba"]["folder"]["public"] =  "yes"
default["samba"]["folder"]["writeable"] =  "yes"
default["samba"]["folder"]["create mask"] = "0777"
default["samba"]["folder"]["directory mask"] = "0777"

case platform
when "arch"
  set["samba"]["config"] = "/etc/samba/smb.conf"
  set["samba"]["log_dir"] = "/var/log/samba/log.%m"
when "redhat","centos","fedora","amazon","scientific"
  set["samba"]["config"] = "/etc/samba/smb.conf"
  set["samba"]["log_dir"] = "/var/log/samba/log.%m"
else
  set["samba"]["config"] = "/etc/samba/smb.conf"
  set["samba"]["log_dir"] = "/var/log/samba/%m.log"
end


      