default['audit']['reporter'] = 'chef-server-automate'
default['audit']['fetcher'] = 'chef-server'


default['audit']['profiles']['Chef Cert Exec Hardening'] = {
  'compliance': 'admin/chef-exec-hardening',
}
