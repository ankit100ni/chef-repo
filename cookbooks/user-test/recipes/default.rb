#
# Cookbook:: user-test
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

require 'digest/sha2'

password = 'pass@123'
salt = rand(36**8).to_s(36)
shadow_hash = password.crypt('$6$' + salt)

user 'random' do
  manage_home true
  comment 'Random User'
  uid 1234
  gid 'users'
  home '/home/random'
  shell '/bin/bash'
  password shadow_hash
end
