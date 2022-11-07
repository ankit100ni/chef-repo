default['appdynamics']['version'] = 'v21.12'

default['appdynamics']['app_name'] = 'my app'
default['appdynamics']['tier_name'] = nil
default['appdynamics']['node_name'] = "#{node['hostname']}"

default['appdynamics']['controller']['host'] = 'my-controller'
default['appdynamics']['controller']['port'] = '8181'
default['appdynamics']['controller']['ssl'] = true
default['appdynamics']['controller']['user'] = 'someuser'
default['appdynamics']['controller']['accesskey'] = 'supersecret'

default['appdynamics']['http_proxy']['host'] = nil
default['appdynamics']['http_proxy']['port'] = nil
default['appdynamics']['http_proxy']['user'] = nil
default['appdynamics']['http_proxy']['password_file'] = nil

default['appdynamics']['unzip_command'] = 'unzip -qq'

default['appdynamics']['packages_site'] = 'https://packages.appdynamics.com'
