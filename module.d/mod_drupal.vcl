/*
 * Module Drupal
 */
 
include "module.d/mod_drupal_acl.vcl";
include "module.d/mod_drupal_lib.vcl";

########[ RECV ]################################################################
sub vcl_recv {
	call denyIfRxCron;
	call pipeIfDrupalStream;
	call passIfDrupalish;
    
	# Conflicts with MOD_Main::removeCookiesFromStaticsRx
    call removeCookiesFromStaticsRxKeepDrupals;
}

########[ HIT ]#################################################################
sub vcl_hit {

}

########[ MISS ]################################################################
sub vcl_miss {

}

########[ FETCH ]###############################################################
sub vcl_fetch {
    # Conflicts with MOD_Main::removeCookiesFromStaticsTx
    call removeCookiesFromStaticsTxKeepDrupals;
}

########[ DELIVER ]#############################################################
sub vcl_deliver {
    if( req.http.X-Varnish-Debug ) {
        set resp.http.X-Varnish-Debug-Mod-Drupal = "Enabled";
    }
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
