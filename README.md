Standarized cookbook templating and naming conventions for chef
===============================================================

Based on [Alessandro Franceschi / Lab42](http://www.example42.com) idea for
*Puppet* modules templating and [Jorge Espada's tmux cookbook](https://github.com/jespada/tmux-cookbook).

This repository contains various **experiments on Chef cookbooks design**.

Alternative solutions are researched and published to provide basic sample
cookbooks that can be used as **blueprint** for the (quick) generation of new
basic cookbooks of different nature, upon which the relevant customizations can
be done.

[A set of common attributes](Attributes_List.md) (and possibly community standard) greatly enhances
cookbooks usability and interoperability. These cookbooks templates
implement an early proposal for a **Standard Cookbook Interface**: a
set of common and standard attributes that provide standard and predictable
functionalities.

I personally think that something like this would be of great benefit for the
Chef Modules ecosystem.

All these cookbooks feature some common principles:

- **True reusability**: you can completely manage the behaviour of the cookbook
  via the attributes it exposes.

- Easy **Multi OS support** implementation: all internal references to paths are
  abtracted when possible.

- **Configuration freedom**: you can provide configuration files, attributes
  and whole dirs in the way you want.

- **Behaviour management**: you can define how the cookbook's resources behave.

- **Decommissioning support**: All the resources can be installed and removed.

### COMMON TOOLS CONFIGURED IN THE GENERATED SCAFFOLD

All these templates create scaffolds ready to start development, with the following
tools configured:

* Berkshelf: For cookbook dependencies management and development.
* Rubocop: for linting.
* Foodcritic: to write cookbooks following best/recommended practices.
* Chefspec: default specs are provided, with descriptive tests for the expected
  basic behaviour. You can run:
```bash
rake spec
```
  in the directory of the created template, to check them.
* Serverspec: to test your cookbook on the server side.
* Kitchen-CI: configured to use chef_zero on the following default vms:
  - opscode-debian-7.4
  - opscode-ubuntu-14.04
  - opscode-centos-6.5
  - opscode-centos-5.10
* Vagrant: to do testings on the mentioned Virtualbox VMs.

### TEMPLATES TYPES

Following the proposed cookbook types from (FIXME!), there are a few templates
to choose from:

#### pack_conf

Tthis template creates a cookbook to manage a package and its
configuration files and directories. Useful for packages that don't have a
daemon or service (ie vim, mc, etc.)

#### pack_conf_serv

This template creates a cookbook to manage an application,
its configuration files and directories and the service/daemon it provides.
Typical examples are apache, ftpd, etc.

### USAGE

1. Clone this repo

2. Chosee the template more suitable for the cookbook you want to create.
   (Check under the **templates** directory).

3. Run
```bash
./cookbook_clone.sh -t pack_conf -n vim
```
4. Change to the newly created directory:
```bash
cd vim-cookbook
```
5. Modify as you please :)

Obviously, there's a lot of room for improvement. These templates don't attempt
to cover all the cookbooks you might need to write and just expect to make it
easier to start writing a cookbook.

Feel free to send me any comments, patches, suggestions or ideas. They will be
very welcome.
