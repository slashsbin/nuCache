/*
 * Module DebugTrigger
 *
 * Triggers:                                                                    
 *     GET:                                                                     
 *         NUCACHE_DEBUG            (Case-InSensitive)
 *                                                                              
 * Depend on Standard VMod
 * Conflicts with Mod-Debug
 */

#import std;

include "module.d/mod_debug_lib.vcl";

########[ RECV ]################################################################
sub vcl_recv {
    if( req.url ~ "(?i)NUCACHE_DEBUG" ) {
        call debugOnRecv;
    }
}

########[ HIT ]#################################################################
sub vcl_hit {
    if( req.url ~ "(?i)NUCACHE_DEBUG" ) {
        call debugOnHit;
    }
}

########[ MISS ]################################################################
sub vcl_miss {
    if( req.url ~ "(?i)NUCACHE_DEBUG" ) {
        call debugOnMiss;
    }
}

########[ FETCH ]###############################################################
sub vcl_fetch {
    if( req.url ~ "(?i)NUCACHE_DEBUG" ) {
        call debugOnFetch;
    }
}

########[ DELIVER ]#############################################################
sub vcl_deliver {
    if( req.http.X-Varnish-Debug ) {
        set resp.http.X-Varnish-Debug-Mod-DebugTrigger = "Enabled";
    }
    
	if( req.url ~ "(?i)NUCACHE_DEBUG" ) {
        call debugOnDeliver;
    }
}

########[ PASS ]################################################################
sub vcl_pass {
    if( req.url ~ "(?i)NUCACHE_DEBUG" ) {
        call debugOnPass;
    }
}

########[ PIPE ]################################################################
sub vcl_pipe {
    if( req.url ~ "(?i)NUCACHE_DEBUG" ) {
        call debugOnPipe;
    }
}

########[ HASH ]################################################################
sub vcl_hash {
    if( req.url ~ "(?i)NUCACHE_DEBUG" ) {
        call debugOnHash;
    }
}

########[ ERROR ]###############################################################
sub vcl_error {
    if( req.url ~ "(?i)NUCACHE_DEBUG" ) {
        call debugOnError;
    }
}

