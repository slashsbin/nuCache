/**
 * Pass if Request is .php or .php5
 */
sub passIfIsPHP {
    if( req.url ~ "\.(php|php5)" ) {
        return (pass);
    }
}

/*
 * Remove Client Cookies which Backend doesn't use
 */
sub removeUnnecessaryPHPCookies {
	if (req.http.Cookie) {
    	/* Warning: Not a pretty solution */
	    /* Prefix header containing cookies with ';' */
	    set req.http.Cookie = ";" + req.http.Cookie;
	    /* Remove any spaces after ';' in header containing cookies */
	    set req.http.Cookie = regsuball(req.http.Cookie, "; +", ";");
	    /* Prefix cookies we want to preserve with one space */
	    /* 'S{1,2}ESS[a-z0-9]+' is the regular expression matching default PHP session cookie ({1,2} added for HTTPS support) */
    	set req.http.Cookie = regsuball(req.http.Cookie, ";(S{1,2}ESS[a-z0-9]+)=", "; \1=");
	    /* Remove from the header any single Cookie not prefixed with a space until next ';' separator */
	    set req.http.Cookie = regsuball(req.http.Cookie, ";[^ ][^;]*", "");
	    /* Remove any '; ' at the start or the end of the header */
	    set req.http.Cookie = regsuball(req.http.Cookie, "^[; ]+|[; ]+$", "");

		if (req.http.Cookie ~ "^[\s;]*$") {
			unset req.http.Cookie;
		}

	}
}
