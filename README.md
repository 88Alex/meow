Meow
====

Package manager for Windows. 

Usage
=====

`meow get package`

`meow install package`

`meow check package` or `meow check`

`meow update package` or `meow update`

`meow uninstall package`

`meow delete package`

`meow list local` or `meow list remote` 

`meow find package`

Packages are by default installed to C:\Program Files\Meow\packages.
To change this, run `meow uninstall package` and then `meow install package --independent`.
This moves the package to C:\Program Files\<package>.
Or, if you want to take the slightly risky option, run `meow set INSTALL "C:\Program Files\"`.

Requirements
============

- Windows XP/Vista/7/8.
- Ruby 1.8.0 or newer
