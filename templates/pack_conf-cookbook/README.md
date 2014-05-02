xxx_template_xxx Cookbook
=============
Installs and configure xxx_template_xxx


Requirements
------------
Platform with a package named 'xxx_template_xxx'. Does a source install on RHEL family.


Attributes
----------
- `node['xxx_template_xxx']['install_method']` - source or package, uses the appropriate recipe.
- `node['xxx_template_xxx']['version']` - version of xxx_template_xxx to download and install from source.
- `node['xxx_template_xxx']['checksum']` - sha256 checksum of the xxx_template_xxx tarball
- `node['xxx_template_xxx']['configure_options']` - array of command line options passed as arguments to the configure script when installing from source.


Usage
-----
Use the recipe for the installation method you want to use, or set the attribute on the node to install from that recipe and use the default recipe. The default recipe also manages `/etc/xxx_template_xxx.conf`.

On RHEL family, `node['xxx_template_xxx']['install_method']` is set to source by default. To install from package, the `yum::epel` recipe is required to get the xxx_template_xxx package, and the attribte would need to be set explicitly.

When installing from source, an install prefix can be set with the `configure_options` attribute. For example:

```ruby
default['xxx_template_xxx']['configure_options'] << "--prefix=/opt/xxx_template_xxx"
```

There are two "private" recipes, `package`, and `source` that are not meant to be included directly in a run_list. They are used by the default recipe and toggled with the node attribute `install_method`.
