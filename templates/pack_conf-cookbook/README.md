xxx_template_xxx Cookbook
=============

Installs and configure xxx_template_xxx

Requirements
------------

Platform with a package named 'xxx_template_xxx'.

Attributes
----------

- `node['xxx_template_xxx']['package']`
  The package name (if different from the cookbook name).
  Default: 'xxx_template_xxx'

- `node['xxx_template_xxx']['version']`
  The package version, used in the version attribute of package resource.
  Can be any valid version number for the target distro.
  Default: nil. 
  Note that if the argument `absent` (see below) is set to `true`, the
    package is removed, whatever the value of the `version` attribute.
  Default: nil

- `node['xxx_template_xxx']['absent']`
  Set to `true` to remove package(s) and files installed by this cookbook.
  Default: false

- `node['xxx_template_xxx']['config_file']`
  Full path to main configuration file.
  Default: '/etc/xxx_template_xxx/xxx_template_xxx.conf'

- `node['xxx_template_xxx']['config_file_mode']`
  Default: 0644

- `node['xxx_template_xxx']['config_file_owner']`
  Default: 'root'

- `node['xxx_template_xxx']['config_file_group']`
  Default: 'root'

- `node['xxx_template_xxx']['config_file_template']`
  Sets the path to the template to use as content for the main configuration
    file. If defined, xxx_template_xxx's main config file has its content
    interpolated from this erb file.
  Note that `config_file_template` and `config_file_source` attributes
    are mutually exclusive: don't use both.
  Default: nil, config file is not modified and is installed as the package's
    maintainers decided.

- `node['xxx_template_xxx']['config_file_source']`
  Sets the content of `cookbook_file` attribute for main configuration file
  Default: nil 

- `node['xxx_template_xxx']['config_dir']`
  Main configuration directory.
  Default: '/etc/xxx_template_xxx'

- `node['xxx_template_xxx']['config_dir_source']`
  If defined, the whole xxx_template_xxx configuration directory is retrieved
  **recursively** from the specified source `remote_directory`.
  Default: nil

- `node['xxx_template_xxx']['source_dir_purge']`
  If set to `true` (default `false`) the configuration directory files
    that are not managed by this cookbook will be removed.
  Default: false

Usage
-----

To use this cookbook, include it in a wrapper cookbook:

* Install xxx_template_xxx package and its configuration file with default settings.

 ```
 include_recipe 'xxx_template_xxx'
 ```

* Install a specific version of xxx_template_xxx package:

 ```
 node.default['xxx_template_xxx']['version'] = '2.1.2'
 include_recipe 'xxx_template_xxx'
 ```

* Remove xxx_template_xxx resources

 ```
 node.default['xxx_template_xxx']['absent'] = true
 include_recipe 'xxx_template_xxx'
 ```

* Use a template to modify the configuration file for xxx_template_xxx

 ```
 node.default['xxx_template_xxx']['config_file_template'] = 'some_template_file'
 include_recipe 'xxx_template_xxx'
 ```
