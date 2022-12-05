#
# Cookbook:: Abinash_test
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

cookbook_file "#{Chef::Config[:file_cache_path]}\\LAPS.x64.msi" do
  source 'LAPS.x64.msi'
end

windows_package 'LAPS.x64.msi' do
  action :install
  source "#{Chef::Config[:file_cache_path]}\\LAPS.x64.msi"
  not_if { (Dir.exist? 'C:\\Program Files\\LAPS') }
end
