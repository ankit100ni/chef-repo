#
# Cookbook:: appdynamics
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

# windows_package 'Appdynamics Machine Agent' do
#   action :install
#   source 'C:\Users\Administrator\Downloads\machineagent-bundle-64bit-windows-22.10.0.3495\InstallService.vbs'
# end

file 'C:\Users\Administrator\Downloads\abc.txt' do
  content 'abc'
  action :create
end
