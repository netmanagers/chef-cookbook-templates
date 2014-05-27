#
# Cookbook Name:: xxx_template_xxx-coobook
# Recipe:: default
#
# Copyright (C) 2014, Javier Bertoli
#
#

## Package management
#
package 'xxx_template_xxx' do
  package_name node['xxx_template_xxx']['package_name']
  version node['xxx_template_xxx']['package_version']
  action node['xxx_template_xxx']['package_action']
end

## Configuration directory management
#
remote_directory 'xxx_template_xxx.dir' do
  path node['xxx_template_xxx']['config_dir_path']
  if %w(remove purge delete).include? node['xxx_template_xxx']['package_action']
    action :delete
  else
    action :create
    only_if { node['xxx_template_xxx']['config_dir_source'] }
  end
  purge node['xxx_template_xxx']['config_dir_purge']
  recursive node['xxx_template_xxx']['config_dir_recurse']
  files_owner node['xxx_template_xxx']['config_file_owner']
  files_group node['xxx_template_xxx']['config_file_group']
  
  node['xxx_template_xxx']['services_notifies'].each do |notif, serv, timer|
    notifies notif, serv, timer
  end
end

# We can't specify both template && source for a file
#
fail '[\'xxx_template_xxx\'][\'config_file_template\'] && '\
     '[\'xxx_template_xxx\'][\'config_file_source\'] can\'t both be set at the same time' \
  if node['xxx_template_xxx']['config_file_template'] && node['xxx_template_xxx']['config_file_source']

# If we use a template
template 'xxx_template_xxx.conf' do
  path node['xxx_template_xxx']['config_file_path']
  if %w(remove purge delete).include? node['xxx_template_xxx']['package_action']
    action :delete
  else
    action :create
    only_if { node['xxx_template_xxx']['config_file_template'] }
  end
  source "#{node['xxx_template_xxx']['config_file_template']}.erb"
  owner node['xxx_template_xxx']['config_file_owner']
  group node['xxx_template_xxx']['config_file_group']
  mode node['xxx_template_xxx']['config_file_mode']
  
  node['xxx_template_xxx']['services_notifies'].each do |notif, serv, timer|
    notifies notif, serv, timer
  end
end

# If we source a file
cookbook_file 'xxx_template_xxx.conf' do
  path node['xxx_template_xxx']['config_file_path']
  if %w(remove purge delete).include? node['xxx_template_xxx']['package_action']
    action :delete
  else
    action :create
    only_if { node['xxx_template_xxx']['config_file_source'] }
  end
  owner node['xxx_template_xxx']['config_file_owner']
  group node['xxx_template_xxx']['config_file_group']
  mode node['xxx_template_xxx']['config_file_mode']
  
  node['xxx_template_xxx']['services_notifies'].each do |notif, serv, timer|
    notifies notif, serv, timer
  end
end

## Service management
service 'xxx_template_xxx' do
  if %w(remove purge delete).include? node['xxx_template_xxx']['package_action']
    action [ :disable, :stop ]
  else
    action node['xxx_template_xxx']['service_actions']
  end
  supports node['xxx_template_xxx']['service_supports']
  if node['xxx_template_xxx']['service_pattern']
    pattern node['xxx_template_xxx']['service_pattern']
  end
  if node['xxx_template_xxx']['service_name']
    service_name node['xxx_template_xxx']['service_name']
  end
  if node['xxx_template_xxx']['service_reload_command']
    service_reload_command node['xxx_template_xxx']['service_reload_command']
  end
  if node['xxx_template_xxx']['service_restart_command']
    service_restart_command node['xxx_template_xxx']['service_restart_command']
  end
  if node['xxx_template_xxx']['service_start_command']
    service_start_command node['xxx_template_xxx']['service_start_command']
  end
  if node['xxx_template_xxx']['service_status_command']
    service_status_command node['xxx_template_xxx']['service_status_command']
  end
  if node['xxx_template_xxx']['service_stop_command']
    service_stop_command node['xxx_template_xxx']['service_stop_command']
  end
  if node['xxx_template_xxx']['service_subscribes']
    subscribes node['xxx_template_xxx']['service_subscribes']
  end
end
