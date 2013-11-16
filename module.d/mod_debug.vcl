/*
 * Module Debug
 * Headers: X-nuCache-Debug-*
 *
 * Depends on Standard VMod
 * Conflicts with Mod-DebugTrigger
 */

#import std;

include "module.d/mod_debug_lib.vcl";

########[ RECV ]################################################################
sub vcl_recv {
	call debugOnRecv;
}

########[ HIT ]#################################################################
sub vcl_hit {
	call debugOnHit;
}

########[ MISS ]################################################################
sub vcl_miss {
	call debugOnMiss;
}

########[ FETCH ]###############################################################
sub vcl_fetch {
	call debugOnFetch;
}

########[ DELIVER ]#############################################################
sub vcl_deliver {
	call debugOnDeliver;
}

########[ PASS ]################################################################
sub vcl_pass {
	call debugOnPass;
}

########[ PIPE ]################################################################
sub vcl_pipe {
	call debugOnPipe;
}

########[ HASH ]################################################################
sub vcl_hash {
	call debugOnHash;
}

########[ ERROR ]###############################################################
sub vcl_error {
	call debugOnError;
}

