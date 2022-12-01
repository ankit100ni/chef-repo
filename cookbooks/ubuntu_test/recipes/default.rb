#
# Cookbook:: ubuntu_test
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

include_profile 'ubuntu_test::client-run'

# exec.chef.crond-permissions:
directory '/etc/cron.d' do
  owner 0
  group 0
  mode '0700'
  action :create
end

# exec.chef.crond-service:

service node['CIS_Ubuntu_Linux_20.04_LTS_Benchmark_Level_1']['scheduler'] do
  action [ :enable, :start ]
end

package node['CIS_Ubuntu_Linux_20.04_LTS_Benchmark_Level_1']['scheduler_package'] do
  action :purge
end

# exec.chef.ssh-config:
service node['CIS_Ubuntu_Linux_20.04_LTS_Benchmark_Level_1']['ssh_config'] do
  action [ :enable, :start ]
end

bash 'Ensure SSH is configured correctly for ClientAliveInterval' do
  code <<-'EOH'
    if grep "^ClientAliveInterval" /etc/ssh/sshd_config > /dev/null 2>&1
    then
      sed -i '/^ClientAliveInterval/c\ClientAliveInterval 3' /etc/ssh/sshd_config
    elif grep "^#ClientAliveInterval" /etc/ssh/sshd_config > /dev/null 2>&1
    then
      sed -i '/^#ClientAliveInterval/c\ClientAliveInterval 3' /etc/ssh/sshd_config
    else
      echo "ClientAliveInterval 3" >> /etc/ssh/sshd_config
    fi
    EOH
  only_if { (File.exist? '/etc/ssh/sshd_config') }
  not_if "grep '^ClientAliveInterval 3$' /etc/ssh/sshd_config"
end

bash 'Ensure SSH is configured correctly for ClientAliveCountMax' do
  code <<-'EOH'
      if grep "^ClientAliveCountMax" /etc/ssh/sshd_config > /dev/null 2>&1
      then
        sed -i '/^ClientAliveCountMax/c\ClientAliveCountMax 3' /etc/ssh/sshd_config
      elif grep "^#ClientAliveCountMax" /etc/ssh/sshd_config > /dev/null 2>&1
      then
        sed -i '/^#ClientAliveCountMax/c\ClientAliveCountMax 3' /etc/ssh/sshd_config
      else
        echo "ClientAliveCountMax 3" >> /etc/ssh/sshd_config
      fi
      EOH
  only_if { (File.exist? '/etc/ssh/sshd_config') }
  not_if "grep '^ClientAliveCountMax 3$' /etc/ssh/sshd_config"
end

bash 'Ensure SSH is configured correctly for Banner' do
  code <<-'EOH'
      if grep "^Banner" /etc/ssh/sshd_config > /dev/null 2>&1
      then
        sed -i '/^Banner/c\Banner /home/ubuntu/banner.txt' /etc/ssh/sshd_config
      elif grep "^#Banner" /etc/ssh/sshd_config > /dev/null 2>&1
      then
        sed -i '/^#Banner/c\Banner /home/ubuntu/banner.txt' /etc/ssh/sshd_config
      else
        echo "Banner /home/ubuntu/banner.txt" >> /etc/ssh/sshd_config
      fi
      EOH
  only_if { (File.exist? '/etc/ssh/sshd_config') }
  not_if "grep '^Banner /home/ubuntu/banner.txt$' /etc/ssh/sshd_config"
end

# exec.chef.user - home - dirs
bash 'Ensure users home directories and they own their home directories' do
  code <<-'EOH'
  echo "Script started"
  cat /etc/passwd | awk -F: '{ print $1 " " $3 " " $6 }' | while read user uid dir; do
    if [ $uid -ge 1000 -a -d "$dir" -a $user != "nobody" ]; then
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
node['CIS_Ubuntu_Linux_20.04_LTS_Benchmark_Level_1']['purge_packages'].each do |pkg_name|
  package pkg_name do
    action :purge
  end
end

bash 'Ensure /tmp is mounted with the noexec and nodev option' do
  code <<-'EOH'
      echo 'UUID=0aef28b9-3d11-4ab4-a0d4-d53d7b4d3aa4 /tmp                    ext4    nodev,noexec        1 2' >> /etc/fstab
      EOH
  not_if "grep 'UUID=0aef28b9-3d11-4ab4-a0d4-d53d7b4d3aa4 /tmp                    ext4    nodev,noexec        1 2' /etc/fstab"
end

bash 'Ensure /var/tmp is mounted with the noexec and nodev option' do
  code <<-'EOH'
      echo '/tmp /var/tmp none nodev,noexec 0 0' >> /etc/fstab
      EOH
  not_if "grep '/tmp /var/tmp none nodev,noexec 0 0' /etc/fstab"
end

package 'telnet' do
  action :purge
end
