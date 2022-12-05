#
# Cookbook:: mde_win19
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

windows_feature_powershell 'Windows-Defender' do
  action :install
  management_tools true
  all true
end

registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Advanced Threat Protection' do
  values [{
    name: 'ForceDefenderPassiveMode',
    type: :dword,
    data: 1,
  }]
  recursive true
  action :create
end

cookbook_file "#{Chef::Config[:file_cache_path]}\\WindowsDefenderATPLocalOnboardingScript.cmd" do
  source 'WindowsDefenderATPLocalOnboardingScript.cmd'
  action :create_if_missing
end

batch 'WindowsDefenderATPLocalOnboardingScript' do
  code "#{Chef::Config[:file_cache_path]}\\WindowsDefenderATPLocalOnboardingScript.cmd"
  action :run
  not_if "$mod=(Get-MpComputerStatus | select AMRunningMode).AMRunningMode; if ($mod -eq 'Passive Mode') { return $true } else { return $false }"
end

service 'windefend' do
  action [ :enable, :start ]
end
