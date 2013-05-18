&nu;Cache
=========
`/sBin/nuCache v1.0.0-dev`

Overview
--------
Varnish-Cache Modular Configuration
with Pre-Defined Production Ready Modules


Features
--------
* Multi-Backends
* Modules
    * [x] Main
    * [x] Custom Error
    * [ ] PHP (TODO)
    * [ ] Drupal (TODO)
    * [x] ShortCicuit
    * [x] ShortCicuit-Trigger
    * [x] Debug
    * [x] Test

Requirements
------------
* Varnish-Cache 3.0 or Higher

Index
-----
* backend.d/        Backends definition files
* backends          Enable/Disable Backends
* module.d/         Modules definition files
* modules           Enable/Disable Modules
* nuCache.vcl       Default
* INSTALL           Installation Manual
* VERSION           nuCache Versoin
* README            Readme
* LICENSE           MIT License

Installation
------------
* Copy files to your Varnish conf folder
* [OPTIONAL] Keep & Rename Default Varnish conf file(default.vcl)
* Set VarnishD conf file to nuCache.vcl
* Enjoy!

See INSTALL Text file for more Information & details.

License
-------
[MIT License]<http://slashsbin.mit-license.org/>



