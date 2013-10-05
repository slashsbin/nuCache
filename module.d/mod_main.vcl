/*
 * Module Main
 *
 * Overrides Default Varnish-Cache Conf file, See mod_default.
 */
 
include "module.d/mod_main_acl.vcl";
include "module.d/mod_main_lib.vcl";

########[ RECV ]################################################################
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
	call removeTrackingCookies;
    
    call cacheAlwaysWWW;
    call cacheAlwaysScripts;
    call cacheAlwaysImages;
    call cacheAlwaysMultimedia;
    call cacheAlwaysXML;
    
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
    call removeCookiesFromStaticsTx;

    #call saintModeOnAny;
    call saintModeOnServerInternalError;
    call saintModeOnServiceUnavailable;

    call hitPassIfHasCookie;
    
    return (deliver);
}

########[ DELIVER ]#############################################################
sub vcl_deliver {
	set resp.http.Via = "nuCache v" + std.fileread("/etc/varnish/VERSION");
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
    call hashUrl;
    call hashServerInfo;
    
    call hashCookieAuth;
    call hashCompressClients;

    return (hash);
}

