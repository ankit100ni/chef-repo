# # Chef InSpec test for recipe ubuntu_test::default

# # The Chef InSpec reference, with examples and extensive documentation, can be
# # found at https://docs.chef.io/inspec/resources/

# title 'Security Hardening Profile'

# control 'exec.chef.crond-permissions' do
#   title 'Ensure permissions on /etc/cron.d are configured'
#   desc  "
#     The /etc/cron.d/ directory contains system cron jobs that need to run in a similar manner to the hourly, daily weekly and monthly jobs from /etc/crontab , but require more granular control as to when they run. The files in this directory cannot be manipulated by the crontab command, but are instead edited by system administrators using a text editor. The commands below restrict read/write and search access to user and group root, preventing regular users from accessing this directory.

#     Rationale: Granting write access to this directory for non-privileged users could provide them the means for gaining unauthorized elevated privileges. Granting read access to this directory could give an unprivileged user insight in how to gain elevated privileges or circumvent auditing controls.
#   "
#   impact 1.0
#   describe.one do
#     describe file('/etc/cron.d') do
#       it { should exist }
#       it { should_not be_executable.by('group') }
#       it { should_not be_readable.by('group') }
#       its('gid') { should cmp 0 }
#       it { should_not be_writable.by('group') }
#       it { should_not be_executable.by('other') }
#       it { should_not be_readable.by('other') }
#       it { should_not be_writable.by('other') }
#       its('uid') { should cmp 0 }
#     end
#   end
# end

# control 'exec.chef.crond-service' do
#   title 'Ensure cron daemon is enabled and running'
#   desc  "
#     The cron daemon is used to execute batch jobs on the system.

#     Rationale: While there may not be user jobs that need to be run on the system, the system does have maintenance jobs that may include security monitoring that have to run. If another method for scheduling tasks is not being used, cron is used to execute them, and needs to be enabled and running.
#   "
#   impact 1.0
#   describe.one do
#     describe service('cron') do
#       it { should be_enabled }
#       it { should be_running }
#     end
#     describe package('cronie') do
#       it { should_not be_installed }
#     end
#   end
# end

# control 'exec.chef.ssh-config' do
#   title 'Ensure SSH is configured correctly'
#   desc "
#     Rationale: SSH needs to be configured securely.
#   "
#   impact 1.0
#   describe sshd_config do
#     its('ClientAliveInterval') { should cmp <=  900 }
#     its('ClientAliveInterval') { should cmp > 0 }
#     its('ClientAliveCountMax') { should cmp <= 3 }
#     its('Banner') { should_not be_nil }
#   end

#   describe service 'sshd' do
#     it { should be_enabled }
#     it { should be_running }
#   end
# end

# control 'exec.chef.user-home-dirs' do
#   title 'Ensure users home directories and they own their home directories'
#   desc  "
#     The user home directory is space defined for the particular user to set local environment variables and to store personal files.

#     Rationale: Since the user is accountable for files stored in the user home directory, the user must be the owner of the directory.
#   "
#   impact 1.0
#   homeslist = {}
#   nologin = [ '/sbin/nologin', '/usr/bin/nologin', '/bin/nologin', '/bin/false' ]
#   passwd.where { user =~ /^(?!root|halt|sync|shutdown).*/ }.where { !nologin.include?(shell) }.users.each_with_index { |k, i| homeslist[k] = passwd.where { user =~ /^(?!root|halt|sync|shutdown).*/ }.where { !nologin.include?(shell) }.homes[i] }
#   homeslist.each do |user, homefolder|
#     describe file(homefolder) do
#       it { should exist }
#       it { should be_directory }
#       it { should be_owned_by user }
#     end
#   end
# end

# control 'exec.chef.http-server' do
#   title 'Ensure HTTP server is not installed'
#   desc  "
#     HTTP or web servers provide the ability to host web site content.

#     Rationale: Unless there is a need to run the system as a web server, the package should be removed
#   "
#   impact 1.0

#   %w(apache apache2 lighttpd nginx httpd).each do |pkg_name|
#     describe package pkg_name do
#       it { should_not be_installed }
#     end
#   end
# end
