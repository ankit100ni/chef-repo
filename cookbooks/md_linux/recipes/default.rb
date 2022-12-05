#
# Cookbook:: md_linux
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

cookbook_file "#{Chef::Config[:file_cache_path]}/Tesco-MDE_Installer.sh" do
  source 'Tesco-MDE_Installer.sh'
  action :create_if_missing
end

cookbook_file "#{Chef::Config[:file_cache_path]}/mdatp_managed.json" do
  source 'mdatp_managed.json'
  action :create_if_missing
end

cookbook_file "#{Chef::Config[:file_cache_path]}/MicrosoftDefenderATPOnboardingLinuxServer.py" do
  source 'MicrosoftDefenderATPOnboardingLinuxServer.py'
  action :create_if_missing
end

%w(audit audit-libs python3).each do |pkg|
  package pkg
end

service 'auditd' do
  action [ :enable, :start ]
end

bash 'Tesco_MDE_Install_Linux' do
  code <<-EOH
  cd #{Chef::Config[:file_cache_path]}
  chmod 700 mdatp_managed.json Tesco-MDE_Installer.sh MicrosoftDefenderATPOnboardingLinuxServer.py
  sudo sh Tesco-MDE_Installer.sh --install --yes
  EOH
  action :run
  not_if { (File.exist? '/opt/microsoft/mdatp/sbin/wdavdaemon') }
end

bash 'turn_mdatp_passive' do
  code <<-EOH
  if [[ $(mdatp health --field passive_mode_enabled) != 'true' ]]
  then
    mdatp config passive-mode --value enabled
  fi
  EOH
  action :run
  live_stream true
end