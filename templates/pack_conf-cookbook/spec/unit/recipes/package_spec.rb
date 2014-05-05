require_relative '../../spec_helper'

describe 'xxx_template_xxx::default' do
  context 'installs xxx_template_xxx with no extra options' do
    let(:chef_run) do
      runner = ChefSpec::Runner.new(
        :platform => 'centos',
        :version => '6.5'
      ).converge('xxx_template_xxx::default')
    end

    it 'installs the distro package' do
      expect(chef_run).to install_package('xxx_template_xxx')
    end
    it 'leave configuration as the distro package says' do
      expect(chef_run).to_not create_template('xxx_template_xxx.conf')
      expect(chef_run).to_not create_remote_directory('xxx_template_xxx.dir')
      expect(chef_run).to_not create_cookbook_file('xxx_template_xxx.conf')
    end

    context 'version attribute is set' do
      let(:chef_run) do
        runner = ChefSpec::Runner.new(
          :platform => 'centos',
          :version => '6.5'
        ).converge('xxx_template_xxx::default')
        runner.node.set['xxx_template_xxx']['package_version'] = '3.2.1'
        runner.converge('xxx_template_xxx::default')
      end

      it 'installs the distro package with a specific version' do
        expect(chef_run).to install_package('xxx_template_xxx').with( :version => '3.2.1') 
      end
    end
  end

  context 'if package_action => remove' do
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
    it 'removes/leave the configuration directory and files according to package instructions' do
      expect(chef_run).to_not delete_template('xxx_template_xxx.conf')
      expect(chef_run).to_not delete_remote_directory('xxx_template_xxx.dir')
      expect(chef_run).to_not delete_cookbook_file('xxx_template_xxx.conf')
    end
  end

end
