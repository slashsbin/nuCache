/*
 * Module Security
 */

########[ RECV ]################################################################
sub vcl_recv {

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
}

########[ DELIVER ]#############################################################
sub vcl_deliver {
    if( req.http.X-nuCache-Debug ) {
        set resp.http.X-nuCache-Debug-Mod-Security = "Enabled";
    }
	unset resp.http.Via;
	unset resp.http.X-Varnish;
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

