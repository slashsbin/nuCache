&nu;Cache
=========
[![Project Status](http://stillmaintained.com/slashsBin/nuCache.png)](http://stillmaintained.com/slashsBin/nuCache) <script type="text/javascript" src="http://www.ohloh.net/p/652070/widgets/project_thin_badge.js"></script>


`/sBin/nuCache v1.1.1`

Overview
--------
Varnish-Cache Modular Configuration
with Pre-Defined Production Ready Modules


Features
--------
* Multi-Backends
* Modules
    * *Main*:                   General Purpose WWW & Server-Side Language InDependant, Core nuCache Module
    * *Custom Error*:           A Custom Error Page
    * *PHP*:					PHP Specific
    * *Drupal*:					Drupal 7.x Specific	
    * *ShortCircuit*:           Varnish Fuze: Pipes All Requests to BackEnd when Enabled
    * *ShortCircuitTrigger*:    Varnish Fuze Trigger: Pipes All Requests to BackEnd when `NUCACHE_FUZE` QueryString is Set
    * *Security*:				WWW Security
    * *Default*:                Default Built-in Varnish-Cache VCL
    * *Debug*:                  Sets Additional Information HTTP Headers for Debug Purposes
    * *Test*:                   Empty Mdoule for Writing Custom Tests
    * *UserCustom*:             Empty Mdoule for Writing Custom User Configurations

Requirements
------------
* Varnish-Cache v3.0.x

Index
-----
* `backend.d/`        					Backends definition files
    * `backend__.vcl.template`			Backend definition sample template
    * `backend__main.vcl`				Main Backend
* `backends.vcl`      					Enable/Disable Backends
* `module.d/`         					Modules definition files
    * `mod_.vcl.template`				Module definition sample template
    * `mod_default.vcl`					MOD Default
    * `mod_main.vcl`					MOD Main
    * `mod_main_lib.vcl`				MOD Main Library
    * `mod_main_acl.vcl`				MOD Main ACL
    * `mod_security.vcl`				MOD Security
    * `mod_php.vcl`						MOD PHP
    * `mod_php_lib.vcl`					MOD PHP Library
    * `mod_drupal.vcl`					MOD Drupal
    * `mod_drupal_lib.vcl`				MOD Drupal Library
    * `mod_drupal_acl.vcl`				MOD Drupal ACL
    * `mod_shortCircuit.vcl`			MOD ShortCircuit
    * `mod_shortCircuitTrigger.vcl`		MOD ShortCircuitTrigger
    * `mod_customError.vcl`				MOD CustomError
    * `mod_debug.vcl`					MOD Debug
    * `mod_test.vcl`					MOD Test
    * `mod_userCustom.vcl`				MOD UserCustom
* `modules.vcl`       					Enable/Disable Modules
* `etc/`              					ETC files
    * `daemon`        					VarnishD Daemon Config
* `nuCache.vcl`       					Bootstarp File
* `INSTALL`           					Installation Manual
* `VERSION`           					nuCache Versoin
* `README.md`         					Readme, You are here!

Installation
------------
1. Keep & Rename Default Varnish conf file(`default.vcl`)
2. Copy files to your Varnish conf folder
3. Use `etc/daemon` as VarnishD Daemon Config file
4. Enjoy!

See INSTALL Text file for more Information & details.

License
-------
nuCache is licensed under the [MIT License](http://slashsbin.mit-license.org/).




