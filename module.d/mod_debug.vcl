/*
 * Module Debug
 * Headers: X-Varnish-Debug-*
 *
 * Depends on Standard VMod
 */

#import std;

########[ RECV ]################################################################
sub vcl_recv {
    # Debug Enabled: Used by other Modules!
    set req.http.X-Varnish-Debug = "DEBUG";
    
    # Trace RECV
    set req.http.X-Varnish-Debug-Trace-RCV = std.toupper(req.proto);
}

########[ HIT ]#################################################################
sub vcl_hit {
    # Trace HIT
    set req.http.X-Varnish-Debug-Trace-HIT = std.toupper(obj.proto);
}

########[ MISS ]################################################################
sub vcl_miss {
    # Trace MISS
    set bereq.http.X-Varnish-Debug-Trace-MIS = std.toupper(bereq.proto);
}

########[ FETCH ]###############################################################
sub vcl_fetch {
    # Trace FETCH
    set beresp.http.X-Varnish-Debug-Trace-FCH = std.toupper(bereq.proto);

    /*
     * Legend:
     * ! : NO
     * ~ : YES
     */

    /*
     * Cache Message
     * Reason of Cache HIT/MISS
     */
    if (beresp.ttl <= 0s) {
        set beresp.http.X-Varnish-Debug-Cache-Msg = "!NotCacheable";
    } elsif (req.http.Cookie) {
        set beresp.http.X-Varnish-Debug-Cache-Msg = "!GotCookie";
    } elsif (beresp.http.Cache-Control ~ "private") {
        set beresp.http.X-Varnish-Debug-Cache-Msg = "!Private";
    } else {
        set beresp.http.X-Varnish-Debug-Cache-Msg = "~SeemsLikeHit";
    }
    
    # Backend Response HTTP Status Code
    set beresp.http.X-Varnish-Debug-B-Code = beresp.status;
    
    # Backend Response TimeToLive
    set beresp.http.X-Varnish-Debug-B-Die = beresp.ttl;
    
    # Backend Request Send Date/Time
    set beresp.http.X-Varnish-Debug-B-Ask = now;
}

########[ DELIVER ]#############################################################
sub vcl_deliver {
    # Trace DELIVER
    set resp.http.X-Varnish-Debug-Trace-DLV = std.toupper(resp.proto);

    # Backend Response Recieve Date/Time
    set resp.http.X-Varnish-Debug-B-Reply = now;

    set resp.http.X-Varnish-Debug-Mod-Debug = "Enabled";

    # Request ID
    set resp.http.X-Varnish-Debug-Guru-Meditation-XID = req.xid;
    
    # HIT or MISS ?
    if (obj.hits > 0) {
        # Cache Status
        set resp.http.X-Varnish-Debug-Cache-Status = "HIT";
    } else {
        # Cache Status
        set resp.http.X-Varnish-Debug-Cache-Status = "MISS";
    }
    
    # Object Hits Count
    set resp.http.X-Varnish-Debug-Object-Hits = obj.hits;
    
    # Object Last Used
    set resp.http.X-Varnish-Debug-Object-LastUsed = obj.lastuse;
    
    # Backend Used to Serve Request
    set resp.http.X-Varnish-Debug-B-Name = req.backend;
    
    # Client Can GZip ?
    if( req.can_gzip ) {
        set resp.http.X-Varnish-Debug-C-GZIP = "~Modern";
    } else {
        set resp.http.X-Varnish-Debug-C-GZIP = "!Old";
    }
    
    # Restart Count till Client Served
    set resp.http.X-Varnish-Debug-Request-Restart = req.restarts;
}

########[ PASS ]################################################################
sub vcl_pass {
    # Trace PASS
    set bereq.http.X-Varnish-Debug-Trace-PSS = std.toupper(req.proto);
}

########[ PIPE ]################################################################
sub vcl_pipe {
    # Trace Pipe
    set bereq.http.X-Varnish-Debug-Trace-PIP = std.toupper(req.proto);
}

########[ HASH ]################################################################
sub vcl_hash {
    # Trace HASH
    set req.http.X-Varnish-Debug-Trace-HSH = std.toupper(req.proto);
}

########[ ERROR ]###############################################################
sub vcl_error {
    # Trace ERROR
    set obj.http.X-Varnish-Debug-Trace-ERR = std.toupper(obj.proto);
}

