&nu;Cache
=========
[![Project Status](http://stillmaintained.com/slashsBin/nuCache.png)](http://stillmaintained.com/slashsBin/nuCache) <script type="text/javascript" src="http://www.ohloh.net/p/652070/widgets/project_thin_badge.js"></script>


`/sBin/nuCache v1.1.3`

Overview
--------
Varnish-Cache Modular Configurations & VCLs
with Pre-Defined Production Ready Templates & Tweaks


Features
--------
* Multi-Backends
* Modules
    * *Main*:                   General Purpose WWW & Server-Side Language InDependant, Core nuCache Module
    * *Custom Error*:           A Custom Error Page
    * *PHP*:					PHP Specific
    * *Drupal*:					Drupal Specific	
    * *ShortCircuit*:           Pipes All Requests to BackEnd when Enabled
    * *ShortCircuitTrigger*:    Same as Mod-ShortCircuit but only when `NUCACHE_FUZE` QueryString is Set
    * *Security*:				General W3 Security
    * *Default*:                Default Built-in Varnish-Cache VCL
    * *Debug*:                  Sets Additional Information HTTP Headers for Debug Purposes
	* *DebugTrigger*:			Same as Mod-Debug but only when `NUCACHE_DEBUG` QueryString is Set
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
    * `mod_default.vcl`					Mod-Default
    * `mod_main.vcl`					Mod-Main(Core)
    * `mod_main_lib.vcl`				Mod-Main Library
    * `mod_main_acl.vcl`				Mod-Main ACL
    * `mod_security.vcl`				Mod-Security
    * `mod_php.vcl`						Mod-PHP
    * `mod_php_lib.vcl`					Mod-PHP Library
    * `mod_drupal.vcl`					Mod-Drupal
    * `mod_drupal_lib.vcl`				Mod-Drupal Library
    * `mod_drupal_acl.vcl`				Mod-Drupal ACL
    * `mod_shortCircuit.vcl`			Mod-ShortCircuit
    * `mod_shortCircuitTrigger.vcl`		Mod-ShortCircuitTrigger
    * `mod_customError.vcl`				Mod-CustomError
    * `mod_debug.vcl`					Mod-Debug
    * `mod_debugTrigger.vcl`			Mod-DebugTrigger
    * `mod_debug_lib.vcl`				Mod-Debug Library
    * `mod_test.vcl`					Mod-Test
    * `mod_userCustom.vcl`				Mod-UserCustom
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

