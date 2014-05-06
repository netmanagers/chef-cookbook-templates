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

