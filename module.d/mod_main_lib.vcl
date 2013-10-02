/**
 * Returns pipe if the request method is not RFC 2616 compliant
 * @link http://www.w3.org/Protocols/rfc2616/rfc2616-sec5.html#sec5.1.1
 */
sub pipeIfNonRFC2616 {
    if (req.request != "GET"     &&
        req.request != "HEAD"    &&
        req.request != "PUT"     &&
        req.request != "POST"    &&
        req.request != "TRACE"   &&
        req.request != "OPTIONS" &&
        req.request != "DELETE") {
		return (pipe);
	}
}

/**
 * Returns "pass" if the request method is not GET or HEAD.
 * POST request will be transfered to the origin server(s)
 *
 * @link https://secure.wikimedia.org/wikipedia/en/wiki/Idempotence
 */
sub passIfNonIdempotent {
	if (req.request != "GET" && req.request != "HEAD") {
		return (pass);
	}
}

/**
 * Set Client IP for a Restarted Request
 */
sub setClientIPOnRestart {
    if (req.restarts > 0) {
        call setClientIPAppend;
    }
}

/**
 * Force Client IP
 */
sub setClientIPOverride {
    remove req.http.X-Forwarded-For;
    set req.http.X-Forwarded-For = client.ip;
}

/**
 * Append Client IP
 */
sub setClientIPAppend {
    if (req.http.X-Forwarded-For) {
        set req.http.X-Forwarded-For = req.http.X-Forwarded-For + ", " + client.ip;
    } else {
        set req.http.X-Forwarded-For = client.ip;
    }
}

/**
 * Returns "pass" if some authorization (i.e .htaccess) is required
 * for the current page
 * and pipe if is authenticated
 */
sub passPipeIfAuthorized {
	if (req.http.Authorization || req.http.Authenticate) {
		return (pass);
	}
	if (req.http.Cookie && req.http.Cookie ~ "authtoken=") {
        return (pipe);
    }
}

/**
 * Removes all cookies from the user request
 */
sub removeCookiesFromAll {
	if(req.http.Cookie) {
		unset req.http.Cookie;
	}
}

/**
 * Removes cookies from static files request
 * and normalizes the request URL
 */
sub removeCookiesFromStaticsRx {
	if (req.url ~ "^/[^?]+\.(jpeg|jpg|png|gif|ico|js|css|txt|gz|zip|lzma|bz2|tgz|tbz|html|htm)(\?.*|)$") {
        unset req.http.cookie;
        set req.url = regsub(req.url, "\?.*$", "");
    }
}

/**
 * Removes cookies from static files response
 * and Sets a High TTL for them
 */
sub removeCookiesFromStaticsTx {
    if (req.url ~ "^/[^?]+\.(bmp|bz2|css|doc|eot|flv|gif|gz|ico|jpeg|jpg|js|less|mp[34]|pdf|png|rar|rtf|swf|tar|tgz|txt|wav|woff|xml|zip)(\?.*)?$") {
        unset beresp.http.set-cookie;
		unset beresp.http.cookie;
    }
	# A TTL of 30 minutes
	set beresp.ttl = 1800s;
}

/*
 * Always Cache Static WWW files
 */
sub cacheAlwaysWWW {
    if( req.request == "GET" && req.url ~ "\.(css|html|htm)$" ) {
        return (lookup);
    }
}

/*
 * Always Cache Javascript files
 */
sub cacheAlwaysScripts {
    if( req.request == "GET" && req.url ~ "\.(js)$" ) {
        return (lookup);
    }
}

/*
 * Always Cache Image files
 */
sub cacheAlwaysImages {
    if( req.request == "GET" && req.url ~ "\.(gif|jpg|jpeg|bmp|png|tiff|tif|ico|img|tga|wmf)$" ) {
        return (lookup);
    }
}

/*
 * Always Cache Multimedia files
 */
sub cacheAlwaysMultimedia {
    if( req.request == "GET" && req.url ~ "\.(svg|swf|mp3|mp4|m4a|ogg|mov|avi|wmv)$" ) {
        return (lookup);
    }
}

/*
 * Always Cache XML files
 */
sub cacheAlwaysXML {
    if( req.request == "GET" && req.url ~ "\.(xml)$" ) {
        return (lookup);
    }
}

/**
 * Normalizes the User-Agent header to its smallest version.
 * This avoids having multiple cache objects for the same browser
 * but with a slightly different User-Agent signature (i.e versio number)
 * and thus maximize your cache hit
 *
 * @link http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.43
 * @link http://www.useragentstring.com/pages/useragentstring.php
 */
sub normalizeUserAgent {
    if (req.http.User-Agent ~ "MSIE") {
        set req.http.User-Agent = "msie";
    } elseif(req.http.User-Agent ~ "Mozilla") {
        set req.http.User-Agent = "mozilla";
    } elseif(req.http.User-Agent ~ "Firefox") {
        set req.http.User-Agent = "firefox";
    } elseif(req.http.User-Agent ~ "Safari") {
        set req.http.User-Agent = "safari";
    } elseif(req.http.User-Agent ~ "Opera Mini/") {
        set req.http.User-Agent = "opera-mini";
    } elseif(req.http.User-Agent ~ "Opera Mobi/") {
        set req.http.User-Agent = "opera-mobile";
    } elseif(req.http.User-Agent ~ "Opera") {
        set req.http.User-Agent = "opera";
    } else {
        set req.http.User-Agent = "unknown";
    }
}

/**
 * Normalizes the Accept-Encoding header to a standard header with either
 * "gzip" or "deflate". This maximize cache hits with respect to the Vary header
 * which is often specified when using things like mod_deflate or any equivalent
 *
 * @link http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.3
 * @link http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.44
 * @link https://httpd.apache.org/docs/2.2/mod/mod_deflate.html
 */
sub normalizeAcceptEncoding {
    if (req.http.Accept-Encoding) {
        if (req.url ~ "\.(jpg|png|gif|gz|tgz|bz2|tbz|mp3|ogg)$") {
            /* we do not need Accept-Encoding for these ones */
            /* don't try to compress already compressed files */
            remove req.http.Accept-Encoding;
        } elsif (req.http.User-Agent ~ "MSIE 6") {
            unset req.http.Accept-Encoding;
        } elsif (req.http.Accept-Encoding ~ "gzip") {
            set req.http.Accept-Encoding = "gzip";
        } elsif (req.http.Accept-Encoding ~ "deflate") {
            set req.http.Accept-Encoding = "deflate";
        } else {
            /* unkown encoding method */
            remove req.http.Accept-Encoding;
        }
    }
}

/*
 * Hit for Pass If Has Cookie Header
 */
sub hitPassIfHasCookie {
    if (beresp.ttl <= 0s ||
        beresp.http.Set-Cookie ||
        beresp.http.Vary == "*") {
        /*
        * Mark as "Hit-For-Pass" for the next 2 minutes
        */
        set beresp.ttl = 120 s;
        return (hit_for_pass);
    }
}

/*
 * Hash URL
 */
sub hashUrl {
    hash_data(req.url);
}

/*
 * Hash Server Info: HTTP Host/Server IP
 */
sub hashServerInfo {
    if (req.http.host) {
        hash_data(req.http.host);
    } else {
        hash_data(server.ip);
    }
}

/*
 * Hash cookie for object with auth
 */
sub hashCookieAuth {
    if (req.http.Cookie) {
        hash_data(req.http.Cookie);
    }
    if (req.http.Authorization) {
        hash_data(req.http.Authorization);
    }
}

/*
 * Hash Accept-Encoding for clients which support compression
 * to keep a different cache
 */
sub hashCompressClients {
    if (req.http.Accept-Encoding) {
        hash_data(req.http.Accept-Encoding);
    }
}

/**
 * BAN a list of object based on the hostname and the URL
 * This subroutine is not compatible with the ban lurker as it
 * uses "req" variables.
 */
sub banIfAllowed {
    if (req.request == "BAN") {
        /**
         * The purge ACL can be controlled in acl.vcl
         */
        if (!client.ip ~ purge) {
            error 405 "Not allowed.";
        }
        
        ban("req.http.host == " + req.http.host + " && req.url ~ " + req.url);
        
        error 200 "Ban added";
    }
}

/*
 * Saint Mode: 500 Internal Server Error
 * Fallback on Grace Mode
 */
sub saintModeOnServerInternalError {
    if (beresp.status == 500) {
        set beresp.saintmode = 10s;
        return(restart);
    }
    set beresp.grace = 5m;
}

/*
 * Saint Mode: 503 Service Unavailable
 * Fallback on Grace Mode
 */
sub saintModeOnServiceUnavailable {
    if (beresp.status == 503) {
        set beresp.saintmode = 10s;
        return(restart);
    }
    set beresp.grace = 5m;
}

/*
 * Saint Mode: 500, 503
 * @see saintModeOnServerInternalError
 * @see saintModeOnServiceUnavailable
 */
sub saintModeOnAny {
    #call saintModeOnServerInternalError;
    #call saintModeOnServiceUnavailable;
    if (beresp.status == 500 || beresp.status == 503) {
        set beresp.saintmode = 10s;
        return(restart);
    }
    set beresp.grace = 5m;
}

