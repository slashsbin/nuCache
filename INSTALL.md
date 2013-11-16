Installation
============
This document describes how to install and configure nuCache as Varnish VCL 
Configurations on Deb-based distros. Please keep in mind that some commands may need root user privileges.

For those who are eager, there is a quick 2-step brief guide on README.md, 
here is a longer descriptive one:

1. Backup Varnish dist files

    ```bash
    $ mv /etc/varnish /etc/varnish.nuCacheSave
    $ mv /etc/default/varnish /etc/default/varnish.nuCacheSave
    ```

2. Copy/Clone nuCache files to `/etc/varnish`

	```bash
	$ cd
	$ curl -LO https://github.com/slashsBin/nuCache/archive/v1.1.1.tar.gz
	$ tar -xzf v1.1.1.tar.gz
	$ mv nuCache-1.1.1 /etc/varnish
	# OR
	$ git clone https://github.com/slashsBin/nuCache.git /etc/varnish
	```
	
3. Use `etc/daemon` file as VarnishD Daemon Config file:

	```bash
	$ ln -s /etc/varnish/etc/daemon /etc/default/varnish
	```
	
4. Configure Storage Type/Size as desired:

    ```bash
    $ vim /etc/default/varnish
    # Look for lines starting with VARNISH_STORAGE
    # You can tweak other settings too!
    
5. Start VarnishD:
    ```bash
    $ service varnish restart
    ```

6. Enjoy!
