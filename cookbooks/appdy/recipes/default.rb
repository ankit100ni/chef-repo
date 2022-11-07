#
# Cookbook:: appdy
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

execute 'VS Script' do
  command 'C:\Users\Administrator\Desktop\machineagent-bundle-64bit-windows-22.10.0.3495\InstallService.vbs'
  action :run
end

service 'Appdynamics Machine Agent' do
  action [ :enable, :start ]
end
