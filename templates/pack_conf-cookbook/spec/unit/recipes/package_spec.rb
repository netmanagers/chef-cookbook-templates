require_relative '../../spec_helper'

describe 'xxx_template_xxx::default' do
  context 'when the cookbook is used with default attributes' do
    let(:chef_run) do
      runner = ChefSpec::Runner.new(
        :platform => 'centos',
        :version => '6.5'
      )
      runner.converge('xxx_template_xxx::default')
    end

    it 'installs the distro-provided package' do
      expect(chef_run).to install_package('xxx_template_xxx')
    end
    it 'installs the distro-provided configuration files and dirs' do
      expect(chef_run).to_not create_template('xxx_template_xxx.conf')
      expect(chef_run).to_not create_remote_directory('xxx_template_xxx.dir')
      expect(chef_run).to_not create_cookbook_file('xxx_template_xxx.conf')
    end
  end

  context 'when the [\'package_version\'] attribute is given a value' do
    let(:chef_run) do
      runner = ChefSpec::Runner.new(
        :platform => 'centos',
        :version => '6.5'
      )
      runner.node.set['xxx_template_xxx']['package_version'] = '3.2.1'
      runner.converge('xxx_template_xxx::default')
    end

    it 'installs the distro-provided package with the specified version' do
      expect(chef_run).to install_package('xxx_template_xxx').with(:version => '3.2.1')
    end
    it 'installs the distro-provided configuration files and dirs' do
      expect(chef_run).to_not create_template('xxx_template_xxx.conf')
      expect(chef_run).to_not create_remote_directory('xxx_template_xxx.dir')
      expect(chef_run).to_not create_cookbook_file('xxx_template_xxx.conf')
    end
  end

  context 'when [\'package_action\'] is set to one of {remove,purge,delete}' do
    let(:chef_run) do
      runner = ChefSpec::Runner.new(
        :platform => 'centos',
        :version  => '6.5'
      )
      runner.node.set['xxx_template_xxx']['package_action'] = 'remove'
      runner.converge('xxx_template_xxx::default')
    end

    it 'removes the package' do
      expect(chef_run).to remove_package('xxx_template_xxx')
    end
    it 'removes the configuration directory and files' do
      expect(chef_run).to delete_template('xxx_template_xxx.conf')
      expect(chef_run).to delete_remote_directory('xxx_template_xxx.dir')
      expect(chef_run).to delete_cookbook_file('xxx_template_xxx.conf')
    end
  end

  context 'when providing a config template via the [\'config_file_template\'] attribute' do
    let(:chef_run) do
      runner = ChefSpec::Runner.new(
        :platform => 'centos',
        :version => '6.5'
      )
      runner.node.set['xxx_template_xxx']['config_file_template'] = 'some_template'
      runner.converge('xxx_template_xxx::default')
    end

    it 'installs the distro-provided configuration __DIRS__' do
      expect(chef_run).to_not create_remote_directory('xxx_template_xxx.dir')
    end
    it 'manages the main configuration __FILE__ via the template' do
      expect(chef_run).to create_template('xxx_template_xxx.conf')
    end
    it 'should not pull the main configuration __FILE__ from a source' do
      expect(chef_run).to_not create_cookbook_file('xxx_template_xxx.conf')
    end
  end

  context 'when pulling a config file from a source via the [\'config_file_source\'] attribute' do
    let(:chef_run) do
      runner = ChefSpec::Runner.new(
        :platform => 'centos',
        :version => '6.5'
      )
      runner.node.set['xxx_template_xxx']['config_file_source'] = 'some_source'
      runner.converge('xxx_template_xxx::default')
    end

    it 'installs the distro-provided configuration __DIRS__' do
      expect(chef_run).to_not create_remote_directory('xxx_template_xxx.dir')
    end
    it 'pulls the main configuration __FILE__ from a source' do
      expect(chef_run).to create_cookbook_file('xxx_template_xxx.conf')
    end
    it 'should not manage the main configuration __FILE__ via the template' do
      expect(chef_run).to_not create_template('xxx_template_xxx.conf')
    end
  end
end
