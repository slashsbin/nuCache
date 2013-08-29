&nu;Cache
=========
[![Project Status](http://stillmaintained.com/slashsBin/nuCache.png)](http://stillmaintained.com/slashsBin/nuCache) <script type="text/javascript" src="http://www.ohloh.net/p/652070/widgets/project_thin_badge.js"></script>


`/sBin/nuCache v1.0.0-dev`

Overview
--------
Varnish-Cache Modular Configuration
with Pre-Defined Production Ready Modules


Features
--------
* Multi-Backends
* Modules
    * *Main*:                   General Purpose WWW & Server-Side Language InDependant, Core nuCache Module
    * *Custom Error*:           A Custom Error Page for Debugging
    * PHP (TODO)
    * Drupal (TODO)
    * *ShortCicuit*:            Varnish Fuze: Pipes All Requests to BackEnd when Enabled
    * *ShortCicuit-Trigger*:    Varnish Fuze Trigger: Pipes All Requests to BackEnd when `VARNISH_FUZE` QueryString is Set
    * *Default*:                Default Built-in Varnish-Cache VCL
    * *Debug*:                  Sets Additional Information HTTP Headers for Debug Purposes
    * *Test*:                   Empty Mdoule for Writing Custom Tests

Requirements
------------
* Varnish-Cache v3.0 or Higher

Index
-----
* `backend.d/`        Backends definition files
* `backends.vcl`      Enable/Disable Backends
* `module.d/`         Modules definition files
* `modules.vcl`       Enable/Disable Modules
* `nuCache.vcl`       Bootstarp File
* `INSTALL`           Installation Manual
* `VERSION`           nuCache Versoin
* `README.md`         Readme, You are here!
* `LICENSE`           MIT License

Installation
------------
1. Copy files to your Varnish conf folder
2. [OPTIONAL] Keep & Rename Default Varnish conf file(default.vcl)
3. Set VarnishD conf file to nuCache.vcl
4. Enjoy!

See INSTALL Text file for more Information & details.

License
-------
[MIT License](http://slashsbin.mit-license.org/)



