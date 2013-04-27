/*
 * Module Debug
 *
 * Headers: X-Varnish-Debug-* 
 */

########[ RECV ]################################################################
sub vcl_recv {
    # Debug Enabled: Used by other Modules!
    set req.http.X-Varnish-Debug = "DEBUG";
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
    # Request ID
    set resp.http.X-Varnish-Debug-RID = req.xid;
    
    if (obj.hits > 0) {
        # Cache Status
        set resp.http.X-Varnish-Debug-Cache-Status = "HIT";
    } else {
        # Cache Status
        set resp.http.X-Varnish-Debug-Cache-Status = "MISS";
    }
    
    # Object Hits
    set resp.http.X-Varnish-Debug-Object-Hits = obj.hits;
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