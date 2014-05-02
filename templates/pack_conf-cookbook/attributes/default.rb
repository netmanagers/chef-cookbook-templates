#
# Cookbook Name:: xxx_template_xxx
# Attribute:: default
#


default['xxx_template_xxx']['install_method'] = case node['platform_family']
                                    when 'rhel'
                                      'source'
                                    else
                                      'package'
                                    end

default['xxx_template_xxx']['version'] = '1.8'
default['xxx_template_xxx']['checksum'] = 'f265401ca890f8223e09149fcea5abcd6dfe75d597ab106e172b01e9d0c9cd44'

default['xxx_template_xxx']['configure_options'] = []

default['xxx_template_xxx']['server_opts']['escape-time'] = 1

default['xxx_template_xxx']['session_opts']['base-index'] = 1
default['xxx_template_xxx']['session_opts']['prefix'] = 'C-a'

default['xxx_template_xxx']['window_opts']['pane-base-index'] = 1
