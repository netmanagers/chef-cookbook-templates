#
# Cookbook Name:: xxx_template_xxx-cookbook
# Recipe:: source
#

packages = case node['platform_family']
           when 'rhel'
             %w(libevent-devel ncurses-devel gcc make)
           else
             %w(libevent-dev libncurses5-dev gcc make)
           end

packages.each do |name|
  package name
end

tar_name = "xxx_template_xxx-#{node['xxx_template_xxx']['version']}"
remote_file "#{Chef::Config['file_cache_path']}/#{tar_name}.tar.gz" do
  source "http://downloads.sourceforge.net/xxx_template_xxx/#{tar_name}.tar.gz"
  checksum node['xxx_template_xxx']['checksum']
  notifies :run, 'bash[install_xxx_template_xxx]', :immediately
end

bash 'install_xxx_template_xxx' do
  user 'root'
  cwd Chef::Config['file_cache_path']
  code <<-EOH
      tar -zxf #{tar_name}.tar.gz
      cd #{tar_name}
      ./configure #{node['xxx_template_xxx']['configure_options'].join(' ')}
      make
      make install
    EOH
  action :nothing
end
