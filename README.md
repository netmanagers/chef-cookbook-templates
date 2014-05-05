Standarized cookbook templating for chef
========================================

Based on [Alessandro Franceschi / Lab42](http://www.example42.com) idea for
*Puppet* modules templating and [Jorge Espada's tmux cookbook](https://github.com/jespada/tmux-cookbook).

This repository contains various **experiments on Chef cookbooks design**.

Alternative solutions are researched and published to provide basic sample
cookbooks that can be used as **blueprint** for the (quick) generation of new
basic cookbooks of different nature, upon which the relevant customizations can
be done.

A set of common parameters (and possibly community standard) greatly enhances
cookbooks usability and interoperability. Some of the cookbooks here (the ones named
**stdmod**) implement an early proposal for a **Standard Module Interface**: a
set of common and standard parameters that provide standard and predictable
functionalities.

I personally think that something like this would be of great benefit for the
Chef Modules ecosystem.

All these cookbooks feature some common principles:

- **True reusability**: you can completely manage the behaviour of the cookbook
  via the parameters it exposes.

- Easy **Multi OS support** implementation: all internal references to paths and
  names are concentrated into a single params class.

  - **Configuration freedom**: you can provide configuration files, parameters
    and whole dirs in the way you want.

  - **Behaviour management**: you can define how the cookbook's resources behave.

  - **Decommissioning support**: All the resources can be installed and removed.

