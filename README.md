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
* [backend.d/](backend.d/)        												Backends definition files
    * [backend__.vcl.template](backend.d/backend__.vcl.template)				Backend definition sample template
    * [backend__main.vcl](backend.d/backend__main.vcl)							Main Backend
* [backends.vcl](backends.vcl)      											Enable/Disable Backends
* [module.d/](module.d/)         												Modules definition files
    * [mod_.vcl.template](module.d/mod_.vcl.template)							Module definition sample template
    * [mod_default.vcl](module.d/mod_default.vcl)								Mod-Default
    * [mod_main.vcl](module.d/mod_main.vcl)										Mod-Main(Core)
    * [mod_main_lib.vcl](module.d/mod_main_lib.vcl)								Mod-Main Library
    * [mod_main_acl.vcl](module.d/mod_main_acl.vcl)								Mod-Main ACL
    * [mod_security.vcl](module.d/mod_security.vcl)								Mod-Security
    * [mod_php.vcl](module.d/mod_php.vcl)										Mod-PHP
    * [mod_php_lib.vcl](module.d/mod_php_lib.vcl)								Mod-PHP Library
    * [mod_drupal.vcl](module.d/mod_drupal.vcl)									Mod-Drupal
    * [mod_drupal_lib.vcl](module.d/mod_drupal_lib.vcl)							Mod-Drupal Library
    * [mod_drupal_acl.vcl](module.d/mod_drupal_acl.vcl)							Mod-Drupal ACL
    * [mod_shortCircuit.vcl](module.d/mod_shortCircuit.vcl)						Mod-ShortCircuit
    * [mod_shortCircuitTrigger.vcl](module.d/mod_shortCircuitTrigger.vcl)		Mod-ShortCircuitTrigger
    * [mod_customError.vcl](module.d/mod_customError.vcl)						Mod-CustomError
    * [mod_debug.vcl](module.d/mod_debug.vcl)									Mod-Debug
    * [mod_debugTrigger.vcl](module.d/mod_debugTrigger.vcl)						Mod-DebugTrigger
    * [mod_debug_lib.vcl](module.d/mod_debug_lib.vcl)							Mod-Debug Library
    * [mod_test.vcl](module.d/mod_test.vcl)										Mod-Test
    * [mod_userCustom.vcl](module.d/mod_userCustom.vcl)							Mod-UserCustom
* [modules.vcl](modules.vcl)       												Enable/Disable Modules
* [etc/](etc/)              													ETC files
    * [daemon](etc/daemon)        												VarnishD Daemon Config
* [nuCache.vcl](nuCache.vcl)       												Bootstarp File
* [INSTALL.md](INSTALL.md)     													Installation Manual
* [VERSION](VERSION)           													nuCache Versoin
* [README.md](README.md)							         					Readme, You are here!

Installation                                                                    
------------                                                                    
1. Copy/Clone nuCache files to `/etc/varnish`

	```bash
	$ cd /etc/varnish
	$ git clone https://github.com/slashsBin/nuCache.git .
	```
2. Use `etc/daemon` file as VarnishD Daemon Config file

	```bash
	# Debian
	$ mv /etc/default/varnish{,.nuCacheSave}
	$ ln -s /etc/varnish/etc/daemon /etc/default/varnish
	# CentOS
	$ mv /etc/sysconfig/varnish{,.nuCacheSave}
	$ ln -s /etc/varnish/etc/daemon /etc/sysconfig/varnish
	```
3. Enjoy!

See INSTALL.md for more Information & details.

License
-------
nuCache is licensed under the [MIT License](http://slashsbin.mit-license.org/).

