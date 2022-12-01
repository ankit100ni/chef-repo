# copyright: 2021, John Tonello

control 'client-run' do
  impact 0.7
  title 'Run the chef-client once an hour'
  if os.windows?
    describe windows_task('run-chef-client') do
      it { should exist }
      it { should be_enabled }
    end
  else
    describe crontab do
      its('commands') { should include '/usr/bin/chef-client' }
      its('minutes') { should include '*/59' }
    end
  end
end
