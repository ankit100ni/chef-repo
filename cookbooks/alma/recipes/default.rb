#
# Cookbook:: alma
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

# exec.chef.crond-service:
service 'crond' do
  action [:enable, :start]
end

package 'cronie' do
  action :remove
end

# exec.chef.http-server:
%w(apache apache2 lighttpd nginx httpd).each do |_pkg_name|
  package 'pkg_name' do
    action :remove
  end
end


