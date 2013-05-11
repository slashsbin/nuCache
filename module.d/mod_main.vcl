/*
 * Module Main
 * Overrides Default Varnish Module!
 */
 
include "module.d/mod_main_acl.vcl";
include "module.d/mod_main_lib.vcl";

########[ RECV ]################################################################
/*
 * Begin Request from c
 * Request is Parsed
 * Return: pass|pipe|lookup
 */
sub vcl_recv {
    #call banIfAllowed;
    #call normalizeUserAgent;
    call normalizeAcceptEncoding;
    
    call setClientIPOnRestart;
    #call setClientIPOverride;
    call setClientIPAppend;
    
    call pipeIfNonRFC2616;
    call passIfNonIdempotent;
    call passPipeIfAuthorized;
    
    #call removeCookiesFromAll;
    call removeCookiesFromStaticsRx;
    
    call cacheAlwaysWWW;
    call cacheAlwaysScripts;
    call cacheAlwaysImages;
    call cacheAlwaysMultimedia;
    call cacheAlwaysXML;
    
    return (lookup);
}

########[ HIT ]#################################################################
/*
 * Cache hit after lookup
 * Return deliver|pass|restart
 */
sub vcl_hit {
    return (deliver);
}

########[ MISS ]################################################################
/*
 * Cache miss after lookup
 * Return fetch|pass
 */
sub vcl_miss {
    return (fetch);
}

########[ FETCH ]###############################################################
/*
 * Fetched from b
 * Return deliver|hit_for_pass|restart
 */
sub vcl_fetch {
    if (beresp.ttl <= 0s ||
        beresp.http.Set-Cookie ||
        beresp.http.Vary == "*") {
        /*
        * Mark as "Hit-For-Pass" for the next 2 minutes
        */
        set beresp.ttl = 120 s;
        return (hit_for_pass);
    }
    call removeCookiesFromStaticsTx;

    #call saintModeOnAny;
    call saintModeOnServerInternalError;
    call saintModeOnServiceUnavailable;
    
    return (deliver);
}

########[ DELIVER ]#############################################################
/*
 * Before delivering cache obj to c
 * Return deliver|restart
 */
sub vcl_deliver {
    return (deliver);
}

########[ PASS ]################################################################
/**
 * Enter pass Mode
 * Return pass|restart
 */
sub vcl_pass {
    return (pass);
}

########[ PIPE ]################################################################
/**
 * Enter pipe Mode
 * Return: pipe
 */
sub vcl_pipe {
    # Note that only the first request to the backend will have
    # X-Forwarded-For set.  If you use X-Forwarded-For and want to
    # have it set for all requests, make sure to have:
    # set bereq.http.connection = "close";
    # here.  It is not set by default as it might break some broken web
    # applications, like IIS with NTLM authentication.
    
    return (pipe);
}

########[ HASH ]################################################################
/*
 * hash_data()
 * Return hash
 */
sub vcl_hash {
    hash_data(req.url);
    if (req.http.host) {
        hash_data(req.http.host);
    } else {
        hash_data(server.ip);
    }
    call hashCookieAuth;
    call hashCompressClients;

    return (hash);
}

########[ ERROR ]###############################################################
/*
 * On Error
 * Return deliver|restart
 */
sub vcl_error {
    set obj.http.Content-Type = "text/html; charset=utf-8";
    set obj.http.Retry-After = "5";
    synthetic {"
        <!DOCTYPE html>
        <html>
            <head>
                <title>"} + obj.status + " " + obj.response + {"</title>
            </head>
        <body>
            <h1>Error "} + obj.status + " " + obj.response + {"</h1>
            <p>"} + obj.response + {"</p>
            <h3>Guru Meditation:</h3>
            <p>XID: "} + req.xid + {"</p>
            <hr>
            <p>Varnish cache server</p>
        </body>
        </html>
    "};

    return (deliver);
}

########[ INIT ]################################################################
/*
 * VCL Loaded
 * Return ok
 */
sub vcl_init {
    return (ok);
}

########[ FINI ]################################################################
/*
 * VCL discarded
 * Return ok
 */
sub vcl_fini {
    return (ok);
}
