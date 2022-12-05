# Chef InSpec test for recipe kitchen_test_win19::default

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

describe service('windefend') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

control 'Checking Windows Defender running in Passive mode' do
  describe registry_key 'HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows Advanced Threat Protection\\Status' do
    its('OnboardingState') { should eq 1 }
  end
end