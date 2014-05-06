# Cookbooks Naming Standards
DRAFT v. 0.0.0

This document sums up and proposes naming conventions for Chef cookbooks.

**They are not supposed to enforce any cookbook's design logic**, so alternative
options and common patterns are outlined for different cookbooks' structure and
functionallity.
 
A Standard Cookbook **is not required** to have all of the names and variables
proposed here, but if some attributes and recipe names are provided that offer
the same function, they should be called as proposed in these conventions.

## Cookbooks names and structure
A cookbook has the **name of the managed application**, system function or
resource it manages.

Using the **package name** as cookbook name is not a good practice as package
names differ among distributions, so a **common name** should be preferred instead.

Example:

Bad naming:

```ruby
postgresql-8::service
mysql5::install
```
Good naming:

```ruby
postgresql::service
mysql::install
```
In case of doubt, already established namings and common sense are the rule.

Resources can be managed in the main recipe and/or in subrecipes.

When a cookbook has subrecipes current standard de-facto names apply:

**recipe::client** - Manages only the client

**recipe::server** - Manages the server installation.

**recipe::install** - Manages only the installation of 'recipe'

**recipe::service** - Manages only the service of 'recipe'

**recipe::config** - Manages the configuration of 'recipe'

**recipe::repo** - Manages eventual extra repos needed for the recipe

Examples:

```ruby
openssh::client
openssh::server
elasticsearch::install
postfix::service
postfix::config
mongodb::repo
```
In the cases that 'recipe' has different sub-applications that can be configured
separatedly or different daemons for each of its parts, subdirectories and
subrecipes might be used to represent each part.

Example:

```ruby
bacula::config
```
For the server application (bacula-director):

```ruby
bacula::server
bacula::server::install
bacula::server::service
bacula::server::config
```
or

```ruby
bacula::director
bacula::director::install
bacula::director::service
bacula::director::config
```
being the latter the preferred naming option:

```ruby
bacula::director::install
bacula::client::service
bacula::storage::config
bacula::console::install
```

### Definitions
The following definitions are reserved for common use cases:
cookbook/definitions/conf     # Definition to manage secondary configuration files for the cookbook
cookbook/definitions/instance # Definition that manages single different instances of the cookbook's application

Example:
```ruby
tomcat/definition/instance
memcached/definition/instance
postfix/definition/conf
```


## Attributes for recipes and definitions
A cookbook may have many different attributes, related to the specific application
it manages, but in order to comply with these *stdmod* guides, some attributes
should have a common naming among cookbooks.

Here are considered **only common attributes** that might be used in any cookbook.

The general **[prefix_]resource_attribute** pattern is followed, to map
consistently recipe attributes with resources attributes.

The use of a prefix should be avoided for recipes or defines that manage a single
resource main configuration file, package or service (ie: **package_action** is
preferred instead of **main_package_action**).

For additional resources a prefix is used denoting the resource itself (ie:
**client_package**, **server_package**).

If there are attributes as the ones defined before in subrecipes or defines,
omonimous resource names are removed or/and have them in short form, without
resource name, in the relevant subrecipe: 

FIXME! PROVIDE EXAMPLES

More generally, in definitions, the shorter version is preferred (for the single
or the main resource managed by the definition, for other resources standard names
with prefixes apply).

### Variables validation and sanitation

FIXME! TURN THIS CHEF-ISH and PROVIDE EXAMPLES

Variables should be validated and sanitized whenever possible, taking in account
these guide lines:

* If a variable has a finite number of possible values, the passed value should be
  checked against this list, or an error should be raised.
* The sanitized value should be stored in a variabled prefixed with *bool_* plus
  the name of the original variable when sanitizing booleans. Ie.:


* The sanitized value should be stored in a variabled prefixed with *real_* plus
  the name of the original variable when sanitizing variables with any number of
  known options. Ie:

* The sanitized value should be stored in a variabled prefixed with *manage_* plus
  the name of the original variable when sanitizing variables affecting control of
  resources. Ie:

### Package and installation management
```
package_name
package_action
package_provider
package_*

other_package
other_package_*

client_package
client_package_*

server_package
server_package_*
```

### Services management
```
service_name
service_action
service_enable
service_subscribe
service_*

other_service
other_service_*

init_script_file
init_script_file_template
init_script_file_options_hash

init_options_file
init_options_file_template
init_options_file_options_hash
```

### Configuration files management
```
config_file_name
config_file_source
config_file_template
config_file_content
config_file_*
config_file_options_hash

config_dir_path
config_dir_source
config_dir_recurse
config_dir_purge
config_dir_*
```

### Reference to common directories
```
home_dir
home_dir_*
data_dir
data_dir_*
log_dir
log_dir_*
bin_dir
bin_dir_*
lib_dir
lib_dir_*
tmp_dir
tmp_dir_*
confd_dir
confd_dir_*
```

### Reference to common files
```
log_file
log_file_owner
log_file_mode
log_file_*

pid_file
pid_file_owner
pid_file_mode
pid_file_*

init_script_file
init_script_file_*
init_config_file
init_config_file_*
```


### Reference to internal recipes that can be substituted

```
dependency_recipe
user_recipe
install_recipe
my_recipe
monitor_recipe
firewall_recipe
repo_recipe
```

### Installations methods
```
install
install_url
install_base_url
install_source
install_destination
install_pre_exec
install_pre_exec_*
install_pre_tmpdir
install_post_exec
install_post_exec_*


install_script_file
install_script_file_*
install_response_file
install_response_file_*
```


### Reference to common resources for monitoring / firewalling
```
tcp_port
udp_port
process_name
process_user
process_group
```
### Exec attributes (for definitions)
```
exec_command
exec_environment
exec_path
exec_*

exec_options_hash
```

### File attributes (for conf definition)
```
path
source
template
content
mode
owner
```

### Attributes for instance definition
```
config_file_template
init_file_template
user
```


### Users management
When a cookbook requires a dedicated user

```
user_name
user_uid
user_gid
user_*

```
