#
# Cookbook:: sophos
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

# windows_package 'Sophos MCS Agent' do
#   source 'C:\Users\Administrator\Documents\SophosSetup.exe'
#   action :install
# end

execute 'Sophos package' do
  command 'C:\Users\Administrator\Documents\SophosSetup.exe SophosSetup.exe --products=antivirus,intercept --quiet'
  action :run
end

service 'Sophos MCS Agent' do
  action [ :enable, :start ]
end
