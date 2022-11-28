#
# Cookbook:: ubuntu_test
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

# users = shell_out!('cat /etc/passwd').stdout.split
# users.each do |user|
#   user = user.split(':')
#   if (user[5]).nil?
#     puts user[5]
#     puts "#{user[0]} has no home dir"
#     user "#{user[0]}" do
#       home "/home/#{user[0]}"
#       force true
#       action :manage
#     end
#   end
# end

# exec.chef.crond-permissions:
directory '/etc/cron.d' do
  owner 0
  group 0
  mode '0700'
  action :create
end

# exec.chef.crond-service:

service 'cron' do
  action [ :enable, :start ]
end

package 'cronie' do
  action :purge
end

# exec.chef.ssh-config:
service 'sshd' do
  action [ :enable, :start ]
end

bash 'Ensure SSH is configured correctl' do
  code <<-'EOH'
sed -i '/^#ClientAliveInterval/c\ClientAliveInterval 3' /etc/ssh/sshd_config
sed -i '/^#ClientAliveCountMax/c\ClientAliveCountMax 3' /etc/ssh/sshd_config
sed -i '/^#Banner/c\Banner /home/ubuntu/banner.txt' /etc/ssh/sshd_config
  EOH
end

# exec.chef.user - home - dirs
bash 'Ensure users home directories and they own their home directories' do
  code <<-'EOH'
  echo "Script started"
  cat /etc/passwd | awk -F: '{ print $1 " " $3 " " $6 }' | while read user uid dir; do
    if [ $uid -ge 1 -a -d "$dir" -a $user != "nfsnobody" ]; then
    owner=$(stat -L -c "%U" "$dir")
      if [ "$owner" != "$user" ]; then
      echo "The home directory ($dir) of user $user is owned by $owner."
      sudo chown "$user":"$user" "$dir"
      fi
    fi
  done
      EOH
end

# exec.chef.http-server:
%w(apache apache2 lighttpd nginx httpd).each do |_pkg_name|
  package 'pkg_name' do
    action :purge
  end
end
