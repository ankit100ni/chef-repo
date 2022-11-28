# Packages
default['CIS_Ubuntu_Linux_20.04_LTS_Benchmark_Level_1']['scheduler_package'] = 'cronie'
default['CIS_Ubuntu_Linux_20.04_LTS_Benchmark_Level_1']['purge_packages'] = %w(apache apache2 lighttpd nginx) # Removed httpd from the list as its a RHEL package

# Services
default['CIS_Ubuntu_Linux_20.04_LTS_Benchmark_Level_1']['scheduler'] = 'cron'
default['CIS_Ubuntu_Linux_20.04_LTS_Benchmark_Level_1']['ssh_config'] = 'sshd'

