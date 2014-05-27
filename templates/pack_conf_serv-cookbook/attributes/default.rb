#
# Cookbook Name:: xxx_template_xxx
# Attribute:: default
#

default['xxx_template_xxx']['package_name'] = 'xxx_template_xxx'
default['xxx_template_xxx']['package_version'] = nil
default['xxx_template_xxx']['package_action'] = 'install'

default['xxx_template_xxx']['config_file_path'] = '/etc/xxx_template_xxx/xxx_template_xxx.conf'
default['xxx_template_xxx']['config_file_mode'] = '0644'
default['xxx_template_xxx']['config_file_owner'] = 'root'
default['xxx_template_xxx']['config_file_group'] = 'root'

default['xxx_template_xxx']['config_file_source'] = nil
default['xxx_template_xxx']['config_file_template'] = nil

default['xxx_template_xxx']['config_dir_path'] = '/etc/xxx_template_xxx'
default['xxx_template_xxx']['config_dir_source'] = nil
default['xxx_template_xxx']['config_dir_purge'] = false

default['xxx_template_xxx']['services_notifies'] = [ ['reload', 'service[xxx_template_xxx]', 'delayed'] ]

default['xxx_template_xxx']['service_name'] = 'xxx_template_xxx'
default['xxx_template_xxx']['service_actions'] = [ 'enable', 'start' ]
default['xxx_template_xxx']['service_supports'] = [ :restart => true, :status => true ]
default['xxx_template_xxx']['service_pattern'] = nil
default['xxx_template_xxx']['service_reload_command'] = nil
default['xxx_template_xxx']['service_restart_command'] = nil
default['xxx_template_xxx']['service_start_command'] = nil
default['xxx_template_xxx']['service_status_command'] = nil
default['xxx_template_xxx']['service_stop_command'] = nil
default['xxx_template_xxx']['service_subscribes'] = nil
