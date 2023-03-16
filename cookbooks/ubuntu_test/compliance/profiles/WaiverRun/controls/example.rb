# copyright: 2018, The Authors

# describe etc_fstab.where { mount_point == '/var/tmp' } do
#   its('mount_options') { should eq [%w(nodev noexec)] }
# end

# describe etc_fstab.where { mount_point == '/tmp' } do
#   its('mount_options') { should eq [%w(nodev noexec)] }
# end

# describe selinux do
#   it { should be_installed }
#   it { should be_enforcing }
# end

# describe package('telnet') do
#   it { should_not be_installed }
# end


control 'exec.chef.telent' do
  title 'Ensure telent server is not installed'
  desc  "
    telnet or web servers provide the ability to host web site content.

    Rationale: Unless there is a need to run the system as a web server, the package should be removed
  "
  impact 1.0

  %w(telent).each do |pkg_name|
    describe package pkg_name do
      it { should_not be_installed }
    end
  end
end

control 'exec.chef.tomcat' do
  title 'Ensure tomcat server is not installed'
  desc  "
    HTTP or web servers provide the ability to host web site content.

    Rationale: Unless there is a need to run the system as a web server, the package should be removed
  "
  impact 1.0

  %w(tomcat).each do |pkg_name|
    describe package pkg_name do
      it { should_not be_installed }
    end
  end
end