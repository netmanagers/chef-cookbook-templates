require 'spec_helper'

describe package('xxx_template_xxx') do
  it { should be_installed }
end

describe file('/etc/xxx_template_xxx/xxx_template_xxx.conf') do
  it { should be_file }
  # it { should be_owned_by 'root' }
  # it { should be_grouped_into 'root' }
  # it { should be_mode '644' }
end

describe service('xxx_template_xxx') do
  it { should be_enabled }
  it { should be_running }
end

# describe port(22) do
  # it { should be_listening }
# end
