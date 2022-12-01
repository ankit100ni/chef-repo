# copyright: 2018, The Authors

describe etc_fstab.where { mount_point == '/var/tmp' } do
  its('mount_options') { should eq [%w(nodev noexec)] }
end

describe etc_fstab.where { mount_point == '/tmp' } do
  its('mount_options') { should eq [%w(nodev noexec)] }
end

describe selinux do
  it { should be_installed }
  it { should be_enforcing }
end

describe package('telnet') do
  it { should_not be_installed }
end
