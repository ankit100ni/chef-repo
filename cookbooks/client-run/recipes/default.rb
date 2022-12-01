#
# Cookbook:: client-run
# Recipe:: default
#
# Copyright:: 2021, John Tonello, All Rights Reserved.

include_profile 'client-run::client-run'

cron 'chef-client' do
  minute '*/59'
  command '/usr/bin/chef-client'
  action :create
end
