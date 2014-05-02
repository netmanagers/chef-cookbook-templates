Standarized cookbook templating for chef
========================================

Based on [Alessandro Franceschi / Lab42](http://www.example42.com) idea for
*Puppet* modules templating and [Jorge Espada's tmux cookbook](https://github.com/jespada/tmux-cookbook).

This repository contains various **experiments on Chef modules design**.

Alternative solutions are researched and published to provide basic sample
modules that can be used as **blueprint** for the (quick) generation of new
basic modules of different nature, upon which the relevant customizations can
be done.

A set of common parameters (and possibly community standard) greatly enhances
modules usability and interoperability. Some of the modules here (the ones named
**stdmod**) implement an early proposal for a **Standard Module Interface**: a
set of common and standard parameters that provide standard and predictable
functionalities.

I personally think that something like this would be of great benefit for the
Chef Modules ecosystem.

All these modules feature some common principles:

- **True reusability**: you can completely manage the behaviour of the module
  via the parameters it exposes.

- Easy **Multi OS support** implementation: all internal references to paths and
  names are concentrated into a single params class.

  - **Configuration freedom**: you can provide configuration files, parameters
    and whole dirs in the way you want.

  - **Behaviour management**: you can define how the module's resources behave.

  - **Decommissioning support**: All the resources can be installed and removed.

