/*
 * Module Drupal
 */
 
include "module.d/mod_drupal_acl.vcl";
include "module.d/mod_drupal_lib.vcl";

########[ RECV ]################################################################
sub vcl_recv {
	call denyIfRxDrupalScripts;
	call pipeIfDrupalStream;
	call passIfDrupalish;

	# Conflicts with ModMain::removeQueryStringFromStaticsRx
	call removeQueryStringFromStaticsRxKeepDrupalish;
	call removeUnnecessaryDrupalishCookies;
}

########[ HIT ]#################################################################
sub vcl_hit {

}

########[ MISS ]################################################################
sub vcl_miss {

}

########[ FETCH ]###############################################################
sub vcl_fetch {

}

########[ DELIVER ]#############################################################
sub vcl_deliver {
    if( req.http.X-nuCache-Debug ) {
        set resp.http.X-nuCache-Debug-Mod-Drupal = "Enabled";
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
