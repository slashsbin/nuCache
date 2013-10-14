/*
 * Module Debug
 * Headers: X-nuCache-Debug-*
 *
 * Depends on Standard VMod
 */

#import std;

########[ RECV ]################################################################
sub vcl_recv {
    # Debug Enabled: Used by other Modules!
    set req.http.X-nuCache-Debug = "DEBUG";
    
    # Trace RECV
    set req.http.X-nuCache-Debug-Trace-RCV = std.toupper(req.proto);
	std.log("====[ nuCache::Debug:RCV ]======================================================");
	
	# Trace URL Changes
    set req.http.X-nuCache-Debug-URL-RCV = req.url;

	# Trace Cookies
	set req.http.X-nuCache-Debug-Cookies-RCV = req.http.Cookie;
}

########[ HIT ]#################################################################
sub vcl_hit {
    # Trace HIT
    set req.http.X-nuCache-Debug-Trace-HIT = std.toupper(obj.proto);
	std.log("====[ nuCache::Debug:HIT ]======================================================");
}

########[ MISS ]################################################################
sub vcl_miss {
    # Trace MISS
    set bereq.http.X-nuCache-Debug-Trace-MIS = std.toupper(bereq.proto);
	std.log("====[ nuCache::Debug:MIS ]======================================================");
}

########[ FETCH ]###############################################################
sub vcl_fetch {
    # Trace FETCH
    set beresp.http.X-nuCache-Debug-Trace-FCH = std.toupper(bereq.proto);
	std.log("====[ nuCache::Debug:FCH ]======================================================");

	# Trace URL Changes
	set beresp.http.X-nuCache-Debug-URL-FCH = req.url;
	if( req.http.X-nuCache-Debug-URL-PSS ) {
		set beresp.http.X-nuCache-Debug-URL-PSS = req.http.X-nuCache-Debug-URL-PSS;
	}

	# Trace Cookies
    set beresp.http.X-nuCache-Debug-Cookies-FCH = req.http.Cookie;
	if( req.http.X-nuCache-Debug-Cookies-PSS ) {
    	set beresp.http.X-nuCache-Debug-Cookies-PSS = req.http.X-nuCache-Debug-Cookies-PSS;
	}

    /*
     * Legend:
     * ! : NO
     * ~ : YES
     */

    /*
     * Cache Message
     * Reason of Cache HIT/MISS
     */
	set beresp.http.X-nuCache-Debug-Cache-Msg-magic = 0;
	set beresp.http.X-nuCache-Debug-Cache-Msg = "{";
	# CRUD
	if (req.request == "GET") {
        set beresp.http.X-nuCache-Debug-Cache-Msg = beresp.http.X-nuCache-Debug-Cache-Msg + "~R:GET";
	} else {
		set beresp.http.X-nuCache-Debug-Cache-Msg-magic = std.integer(beresp.http.X-nuCache-Debug-Cache-Msg-magic, 0) + 1;
        set beresp.http.X-nuCache-Debug-Cache-Msg = beresp.http.X-nuCache-Debug-Cache-Msg + "!CUD:" + req.request;
	}
	# TTL
    if (beresp.ttl <= 0s) {
		set beresp.http.X-nuCache-Debug-Cache-Msg-magic = std.integer(beresp.http.X-nuCache-Debug-Cache-Msg-magic, 0) + 1;
        set beresp.http.X-nuCache-Debug-Cache-Msg = beresp.http.X-nuCache-Debug-Cache-Msg + "|!NotCacheable:WillDie";
    } else {
        set beresp.http.X-nuCache-Debug-Cache-Msg = beresp.http.X-nuCache-Debug-Cache-Msg + "|~Cacheable";
	}
	# COOKIE
	if (req.http.Cookie) {
		set beresp.http.X-nuCache-Debug-Cache-Msg-magic = std.integer(beresp.http.X-nuCache-Debug-Cache-Msg-magic, 0) + 1;
        set beresp.http.X-nuCache-Debug-Cache-Msg = beresp.http.X-nuCache-Debug-Cache-Msg + "|!GotCookie";
    } else {
        set beresp.http.X-nuCache-Debug-Cache-Msg = beresp.http.X-nuCache-Debug-Cache-Msg + "|~NoFood";
	}
	# Cache-Control
	if (beresp.http.Cache-Control ~ "private") {
		set beresp.http.X-nuCache-Debug-Cache-Msg-magic = std.integer(beresp.http.X-nuCache-Debug-Cache-Msg-magic, 0) + 1;
        set beresp.http.X-nuCache-Debug-Cache-Msg = beresp.http.X-nuCache-Debug-Cache-Msg + "|!Private";
    } else {
        set beresp.http.X-nuCache-Debug-Cache-Msg = beresp.http.X-nuCache-Debug-Cache-Msg + "|~Public";
    }
	set beresp.http.X-nuCache-Debug-Cache-Msg = beresp.http.X-nuCache-Debug-Cache-Msg + "}";
	if(std.integer(beresp.http.X-nuCache-Debug-Cache-Msg-magic, 0) > 0) {
		set beresp.http.X-nuCache-Debug-Cache-Msg = "!SeemsLikeMiss" + beresp.http.X-nuCache-Debug-Cache-Msg + ":" + beresp.http.X-nuCache-Debug-Cache-Msg-magic;
	} else {
		set beresp.http.X-nuCache-Debug-Cache-Msg = "~SeemsLikeHit" + beresp.http.X-nuCache-Debug-Cache-Msg + ":0";
	}
	unset beresp.http.X-nuCache-Debug-Cache-Msg-magic;
    
    # Backend Response HTTP Status Code
    set beresp.http.X-nuCache-Debug-B-Code = beresp.status;
    
    # Backend Response TimeToLive
    set beresp.http.X-nuCache-Debug-B-Die = beresp.ttl;
    
    # Backend Request Send Date/Time
    set beresp.http.X-nuCache-Debug-B-Ask = now;
}

########[ DELIVER ]#############################################################
sub vcl_deliver {
    # Trace DELIVER
    set resp.http.X-nuCache-Debug-Trace-DLV = std.toupper(resp.proto);
	std.log("====[ nuCache::Debug:DLV ]======================================================");

	# HTTP Method
	set resp.http.X-nuCache-Debug-Method = req.request;

	# Trace URL Changes
    set resp.http.X-nuCache-Debug-URL-DLV = req.url;
	set resp.http.X-nuCache-Debug-URL-RCV = req.http.X-nuCache-Debug-URL-RCV;

	# Trace Cookies
    set resp.http.X-nuCache-Debug-Cookies-DLV = req.http.Cookie;
    set resp.http.X-nuCache-Debug-Cookies-RCV = req.http.X-nuCache-Debug-Cookies-RCV;


    # Backend Response Recieve Date/Time
    set resp.http.X-nuCache-Debug-B-Reply = now;

    set resp.http.X-nuCache-Debug-Mod-Debug = "Enabled";

    # Request ID
    set resp.http.X-nuCache-Debug-Guru-Meditation-XID = req.xid;
    
    # HIT or MISS ?
    if (obj.hits > 0) {
        # Cache Status
        set resp.http.X-nuCache-Debug-Cache-Status = "~HIT";
    } else {
        # Cache Status
        set resp.http.X-nuCache-Debug-Cache-Status = "!MISS";
    }
    
    # Object Hits Count
    set resp.http.X-nuCache-Debug-Object-Hits = obj.hits;
    
    # Object Last Used
    set resp.http.X-nuCache-Debug-Object-LastUsed = obj.lastuse;
    
    # Backend Used to Serve Request
    set resp.http.X-nuCache-Debug-B-Name = req.backend;
    
    # Client Can GZip ?
    if( req.can_gzip ) {
        set resp.http.X-nuCache-Debug-C-GZIP = "~Modern";
    } else {
        set resp.http.X-nuCache-Debug-C-GZIP = "!Old";
    }
    
    # Restart Count till Client Served
    set resp.http.X-nuCache-Debug-Request-Restart = req.restarts;
}

########[ PASS ]################################################################
sub vcl_pass {
    # Trace PASS
    set bereq.http.X-nuCache-Debug-Trace-PSS = std.toupper(req.proto);
	std.log("====[ nuCache::Debug:PSS ]======================================================");

	# Trace URL Changes
    set bereq.http.X-nuCache-Debug-URL-PSS = req.url;

	# Trace Cookies
    set bereq.http.X-nuCache-Debug-Cookies-PSS = req.http.Cookie;

}

########[ PIPE ]################################################################
sub vcl_pipe {
    # Trace Pipe
    set bereq.http.X-nuCache-Debug-Trace-PIP = std.toupper(req.proto);
	std.log("====[ nuCache::Debug:PIP ]======================================================");

	# Trace URL Changes
    set bereq.http.X-nuCache-Debug-URL-PIP = req.url;
}

########[ HASH ]################################################################
sub vcl_hash {
    # Trace HASH
    set req.http.X-nuCache-Debug-Trace-HSH = std.toupper(req.proto);
	std.log("====[ nuCache::Debug:HSH ]======================================================");
}

########[ ERROR ]###############################################################
sub vcl_error {
    # Trace ERROR
    set obj.http.X-nuCache-Debug-Trace-ERR = std.toupper(obj.proto);
	std.log("====[ nuCache::Debug:ERR ]======================================================");
}

