/*
 * Module Default
 * Varnich-Cache Default Configuration
 *
 * Usefull if You want to:
 *      + Disable All Modules & Revert back to Varnish Default
 *      + Reference Purposes
 *      + A Fallback for Other Custom Modules
 *      + Test/Tweak the Way Default Works
 */

########[ RECV ]################################################################
sub vcl_recv {
    if (req.restarts == 0) {
        if (req.http.x-forwarded-for) {
            set req.http.X-Forwarded-For = req.http.X-Forwarded-For + ", " + client.ip;
        } else {
            set req.http.X-Forwarded-For = client.ip;
        }
    }
    if (req.request != "GET" &&
        req.request != "HEAD" &&
        req.request != "PUT" &&
        req.request != "POST" &&
        req.request != "TRACE" &&
        req.request != "OPTIONS" &&
        req.request != "DELETE") {
            /* Non-RFC2616 or CONNECT which is weird. */
            return (pipe);
    }
    if (req.request != "GET" && req.request != "HEAD") {
        /* We only deal with GET and HEAD by default */
        return (pass);
    }
    if (req.http.Authorization || req.http.Cookie) {
        /* Not cacheable by default */
        return (pass);
    }
    return (lookup);
}

########[ HIT ]#################################################################
sub vcl_hit {
    return (deliver);
}

########[ MISS ]################################################################
sub vcl_miss {
    return (fetch);
}

########[ FETCH ]###############################################################
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
    return (deliver);
}

########[ DELIVER ]#############################################################
sub vcl_deliver {
    return (deliver);
}

########[ PASS ]################################################################
sub vcl_pass {
    return (pass);
}

########[ PIPE ]################################################################
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
sub vcl_hash {
    hash_data(req.url);
    if (req.http.host) {
        hash_data(req.http.host);
    } else {
        hash_data(server.ip);
    }
    return (hash);
}

########[ ERROR ]###############################################################
sub vcl_error {
    set obj.http.Content-Type = "text/html; charset=utf-8";
    set obj.http.Retry-After = "5";
    synthetic {"
    <?xml version="1.0" encoding="utf-8"?>
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
    <html>
        <head>
            <title>"} + obj.status + " " + obj.response + {"</title>
        </head>
        <body>
            <h1>Error "} + obj.status + " " + obj.response + {"</h1>
            <p>"} + obj.response + {"</p>
            <h3>Guru Meditation:</h3>
            <p>XID: "} + req.xid + {"</p>
            <hr />
            <p>Varnish cache server</p>
        </body>
    </html>
    "};
    
    return (deliver);
}

########[ INIT ]################################################################ 
sub vcl_init {
    return (ok);
}

########[ FINI ]################################################################ 
sub vcl_fini {
    return (ok);
}

