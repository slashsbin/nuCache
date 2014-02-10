
/*
 * Module Security
 */

include "module.d/mod_security_acl.vcl";
include "module.d/mod_security_lib.vcl";

########[ RECV ]################################################################
sub vcl_recv {
	call secureAccess;
}

########[ HIT ]#################################################################
sub vcl_hit {

}

########[ MISS ]################################################################
sub vcl_miss {

}

########[ FETCH ]###############################################################
sub vcl_fetch {
	unset beresp.http.Server;
	unset beresp.http.X-Powered-By;
	unset beresp.http.X-AspNet-Version;
}

########[ DELIVER ]#############################################################
sub vcl_deliver {
    if( req.http.X-nuCache-Debug ) {
        set resp.http.X-nuCache-Debug-Mod-Security = "Enabled";
    }
	unset resp.http.Via;
	unset resp.http.X-Varnish;
	unset resp.http.X-Drupal-Cache;
	set resp.http.X-Frame-Options = "SAMEORIGIN";
}

########[ PASS ]################################################################
sub vcl_pass {

}

########[ PIPE ]################################################################
sub vcl_pipe {

}

########[ HASH ]################################################################
sub vcl_hash {

}

