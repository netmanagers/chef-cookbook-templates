#
# Cookbook Name:: xxx_template_xxx-coobook
# Recipe:: default
#
# Copyright (C) 2014, Javier Bertoli
#
#

# Package management
#
package 'xxx_template_xxx' do
  package_name node['xxx_template_xxx']['package_name']
  version node['xxx_template_xxx']['package_version']
  action node['xxx_template_xxx']['package_action']
end

# Configuration directory management
#
remote_directory 'xxx_template_xxx.dir' do
  path node['xxx_template_xxx']['config_dir_path']
  if ['remove', 'purge', 'delete'].include? node['xxx_template_xxx']['package_action']
    action :delete
  else
    action :create
  end
  only_if { node['xxx_template_xxx']['config_dir_source'] }
  purge node['xxx_template_xxx']['config_dir_purge']
  recursive node['xxx_template_xxx']['config_dir_recurse']
  files_owner node['xxx_template_xxx']['config_file_owner']
  files_group node['xxx_template_xxx']['config_file_group']
end

# We can't specify both template && source for a file
#
if node['xxx_template_xxx']['config_file_template'] && node['xxx_template_xxx']['config_file_source']
  Chef::Application.fatal! "['xxx_template_xxx']['config_file_template'] && ['xxx_template_xxx']['config_file_source'] can't both be set at the same time"
end

# If we use a template
template 'xxx_template_xxx.conf' do
  path node['xxx_template_xxx']['config_file_path']
  if ['remove', 'purge', 'delete'].include? node['xxx_template_xxx']['package_action']
    action :delete
  else
    action :create
  end
  only_if { node['xxx_template_xxx']['config_file_template'] }
  source "#{node['xxx_template_xxx']['config_file_template']}.erb"
  owner node['xxx_template_xxx']['config_file_owner']
  group node['xxx_template_xxx']['config_file_group']
  mode node['xxx_template_xxx']['config_file_mode']
end

# If we source a file
cookbook_file 'xxx_template_xxx.conf' do
  path node['xxx_template_xxx']['config_file_path']
  if ['remove', 'purge', 'delete'].include? node['xxx_template_xxx']['package_action']
    action :delete
  else
    action :create
  end
  only_if { node['xxx_template_xxx']['config_file_source'] }
  owner node['xxx_template_xxx']['config_file_owner']
  group node['xxx_template_xxx']['config_file_group']
  mode node['xxx_template_xxx']['config_file_mode']
end
