/*
 * Module Pipe Short Circuit
 */

########[ RECV ]################################################################
sub vcl_recv {
    return (pipe);
}

########[ HIT ]#################################################################
sub vcl_hit {
    return (deliver);
}

########[ MISS ]################################################################
sub vcl_miss {
    return (pass);
}

########[ FETCH ]###############################################################
sub vcl_fetch {
    return (deliver);
}

########[ DELIVER ]#############################################################
sub vcl_deliver {
	if( req.http.X-nuCache-Debug ) {                                            
        set resp.http.X-nuCache-Debug-Mod-ShortCircuit = "Enabled";
    }

    return (deliver);
}

########[ PASS ]################################################################
sub vcl_pass {
    return (pass);
}

########[ PIPE ]################################################################
sub vcl_pipe {
    return (pipe);
}

########[ HASH ]################################################################
sub vcl_hash {
    return (hash);
}

