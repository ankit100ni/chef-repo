#
# Cookbook:: nessus
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

windows_package 'Nessus-10.4.1-x64.msi' do
  source 'C:\Users\Administrator\Downloads\Nessus-10.4.1-x64.msi'
  checksum 'ea7c8faba30aaddd57eb692540a81789cf263b66f794b275f789905758be88ca'
end
