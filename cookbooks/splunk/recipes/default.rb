#
# Cookbook:: splunk
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

windows_package 'Sophos' do
  action :install
  source 'C:\Users\Administrator\Documents\SophosInstall.zip'
end
