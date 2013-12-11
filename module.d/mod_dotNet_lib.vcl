/**
 * Cache Always .Net Web Handlers:
 * + WebResource.axd
 * + ScriptResource.axd
 */
sub cacheAlwaysDotNetHandlers {
	if( req.request == "GET" && req.url ~ ".*(?:Web|Script)Resource\.axd.*" ) {
        return (lookup);
    }
}

