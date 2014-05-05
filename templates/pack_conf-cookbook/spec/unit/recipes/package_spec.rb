require_relative '../../spec_helper'

describe 'xxx_template_xxx::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'installs xxx_template_xxx with no extra options' do
    expect(chef_run).to install_package('xxx_template_xxx')
    expect(chef_run).to_not create_template('xxx_template_xxx.conf')
    expect(chef_run).to_not create_remote_directory('xxx_template_xxx.dir')
    expect(chef_run).to_not create_cookbook_file('xxx_template_xxx.conf')
  end
end
