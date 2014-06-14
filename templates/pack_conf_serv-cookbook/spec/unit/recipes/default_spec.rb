require_relative '../../spec_helper'

describe 'xxx_template_xxx::default' do
  ###
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
    it 'installs/creates the distro-provided configuration files and dirs' do
      expect(chef_run).to_not create_template('xxx_template_xxx.conf')
      expect(chef_run).to_not create_remote_directory('xxx_template_xxx.dir')
      expect(chef_run).to_not create_cookbook_file('xxx_template_xxx.conf')
    end
    it 'enables and starts the service' do
      expect(chef_run).to start_service('xxx_template_xxx')
      expect(chef_run).to enable_service('xxx_template_xxx')
    end
  end

  ###
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
    it 'installs/creates the distro-provided configuration files and dirs' do
      expect(chef_run).to_not create_template('xxx_template_xxx.conf')
      expect(chef_run).to_not create_remote_directory('xxx_template_xxx.dir')
      expect(chef_run).to_not create_cookbook_file('xxx_template_xxx.conf')
    end
  end

  ###
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
    it 'removes the configuration files and dirs' do
      expect(chef_run).to delete_template('xxx_template_xxx.conf')
      expect(chef_run).to delete_remote_directory('xxx_template_xxx.dir')
      expect(chef_run).to delete_cookbook_file('xxx_template_xxx.conf')
    end
    it 'disables and stops the service' do
      expect(chef_run).to stop_service('xxx_template_xxx')
      expect(chef_run).to disable_service('xxx_template_xxx')
    end
  end

  #### CONFIG TESTS
  ###
  context 'when setting [\'config_file_template\'] and [\'config_file_source\'] at the same time' do
    let(:chef_run) do
      runner = ChefSpec::Runner.new(
        :platform => 'centos',
        :version => '6.5'
      )
      runner.node.set['xxx_template_xxx']['config_file_template'] = 'some_template'
      runner.node.set['xxx_template_xxx']['config_file_source'] = 'some_source'
      runner.converge('xxx_template_xxx::default')
    end

    it 'raises a fatal error' do
      expect { chef_run }.to raise_error('[\'xxx_template_xxx\'][\'config_file_template\'] && '\
                                         '[\'xxx_template_xxx\'][\'config_file_source\'] can\'t '\
                                         'both be set at the same time')
    end
  end

  ###
  context 'when pulling the whole config dir from a source via the [\'config_dir_source\'] attribute' do
    let(:chef_run) do
      runner = ChefSpec::Runner.new(
        :platform => 'debian',
        :version => '7.4'
      )
      runner.node.set['xxx_template_xxx']['config_dir_source'] = 'some_source'
      runner.converge('xxx_template_xxx::default')
    end

    it 'pulls the whole configuration __DIR__ from a source' do
      expect(chef_run).to create_remote_directory('xxx_template_xxx.dir')
    end

    it 'notifies "service[xxx_template_xxx]" to reload delayed' do
      resource = chef_run.remote_directory('xxx_template_xxx.dir')
      expect(resource).to notify('service[xxx_template_xxx]').to(:reload).delayed
    end
  end

  ###
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
    it 'does not pull the main configuration __FILE__ from source' do
      expect(chef_run).to_not create_cookbook_file('xxx_template_xxx.conf')
    end

    it 'notifies "service[xxx_template_xxx]" to reload delayed' do
      resource = chef_run.cookbook_file('xxx_template_xxx.conf')
      expect(resource).to notify('service[xxx_template_xxx]').to(:reload).delayed
    end
  end

  ###
  context 'when pulling a config file from a source via the [\'config_file_source\'] attribute' do
    let(:chef_run) do
      runner = ChefSpec::Runner.new(
        :platform => 'centos',
        :version => '6.5'
      )
      runner.node.set['xxx_template_xxx']['config_file_source'] = 'some_source'
      runner.converge('xxx_template_xxx::default')
    end

    it 'installs the distro-provided configuration __DIR__' do
      expect(chef_run).to_not create_remote_directory('xxx_template_xxx.dir')
    end
    it 'pulls the main configuration __FILE__ from a source' do
      expect(chef_run).to create_cookbook_file('xxx_template_xxx.conf')
    end
    it 'does not manage the main configuration __FILE__ via the template' do
      expect(chef_run).to_not create_template('xxx_template_xxx.conf')
    end

    it 'notifies "service[xxx_template_xxx]" to reload delayed' do
      resource = chef_run.template('xxx_template_xxx.conf')
      expect(resource).to notify('service[xxx_template_xxx]').to(:reload).delayed
    end
  end

  ###
  context 'when specifying multiple services to notify via the [\'services_notifies\'] attribute (please check this section in the spec file)' do
    let(:chef_run) do
      runner = ChefSpec::Runner.new(
        :platform => 'centos',
        :version => '6.5'
      )
      runner.node.set['xxx_template_xxx']['config_file_source'] = 'some_source'

      # This is a stub test, as you need to include_recipe before being able to notify services
      # on other recipes: https://github.com/sethvargo/chefspec/issues/121
      # Apparently you cannot just mock them.
      runner.node.set['xxx_template_xxx']['services_notifies'] = [['reload', 'service[xxx_template_xxx]', 'delayed']]

      #      runner.node.set['xxx_template_xxx']['services_notifies'] = [['reload', 'service[xxx_template_xxx]', 'delayed'],
      #                                                                   ['restart','service[another_service]', 'immediately'],
      #                                                                   ['run', 'execute[test-nagios-config]', 'immediately']]

      runner.converge('xxx_template_xxx::default')
    end

    it 'notifies "service[xxx_template_xxx]" to reload delayed' do
      resource = chef_run.template('xxx_template_xxx.conf')
      expect(resource).to notify('service[xxx_template_xxx]').to(:reload).delayed
    end
    #    it 'notifies "service[another_service]" to restart immediately' do
    #      resource = chef_run.template('xxx_template_xxx.conf')
    #      expect(resource).to notify('service[notification1]').to(:restart).immediately
    #    end
    #    it 'notifies "execute[test-nagios-config]" to run immediately' do
    #      resource = chef_run.template('xxx_template_xxx.conf')
    #      expect(resource).to notify('execute[notification2]').to(:run).immediately
    #    end
  end

  #### SERVICE TESTS
  ###
  context 'when [\'service_actions\'] attribute has other values than the defaults' do
    let(:chef_run) do
      runner = ChefSpec::Runner.new(
        :platform => 'centos',
        :version => '6.5'
      )
      runner.node.set['xxx_template_xxx']['service_actions'] = %w(stop, enable)
      runner.converge('xxx_template_xxx::default')
    end

    it 'ie, stop and but enable the service' do
      expect(chef_run).to stop_service('xxx_template_xxx')
      expect(chef_run).to enable_service('xxx_template_xxx')
    end
  end
end
