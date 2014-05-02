#
# Cookbook Name:: xxx_template_xxx-coobook
# Recipe:: default
#
# Copyright (C) 2014, Jorge Espada
#
#

# Example to show external dependencies (depends 'foo') on metadata.rb
# include_recipe 'foo'


begin
  include_recipe "xxx_template_xxx::#{node['xxx_template_xxx']['install_method']}"
rescue Chef::Exceptions::RecipeNotFound
  Chef::Application.fatal! "'#{node['xxx_template_xxx']['install_method']}' is not a valid installation method for the xxx_template_xxx cookbook!"
end

template '/etc/xxx_template_xxx.conf' do
  source 'xxx_template_xxx.conf.erb'
  owner  'root'
  group  'root'
  mode   '0644'
  variables(
    :server_opts  => node['xxx_template_xxx']['server_opts'].to_hash,
    :session_opts => node['xxx_template_xxx']['session_opts'].to_hash,
    :window_opts  => node['xxx_template_xxx']['window_opts'].to_hash
  )
end
