/**
 * Removes cookies from static files request
 * and normalizes the request URL
 */
sub removeCookiesFromStaticsRxKeepDrupals {
    if (req.url ~ "^/[^?]+\.(jpeg|jpg|png|gif|ico|js|css|txt|gz|zip|lzma|bz2|tgz|tbz|html|htm)(\?.*|)$") {
        unset req.http.cookie;
        set req.url = regsub(req.url, "\?.*$", "");
    }
}

/**
 * Removes cookies from static files response
 */
sub removeCookiesFromStaticsTxKeepDrupals {
    if (req.url ~ "^/[^?]+\.(bmp|bz2|css|doc|eot|flv|gif|gz|ico|jpeg|jpg|js|less|mp[34]|pdf|png|rar|rtf|swf|tar|tgz|txt|wav|woff|xml|zip)(\?.*)?$") {
        unset beresp.http.set-cookie;
		unset beresp.http.cookie;
		# A TTL of 30 minutes
		set beresp.ttl = 1800s;
    }
}

/**
 * Block access to Drupal cron script from outsite
 */
sub denyIfRxCron {
	if (req.url ~ "^/(cron|install)\.php$" && !client.ip ~ drupal_internal) {
		error 403 "Forbidden.";
	}
}

/**
 * Do NOT cache any Drupal specific Paths
 */
sub passIfDrupalish {
	if (req.url ~ "^/status\.php$" ||
		req.url ~ "^/update\.php$" ||
		req.url ~ "^/admin/build/features" ||
		req.url ~ "^/info/.*$" ||
      	req.url ~ "^/flag/.*$" ||
      	req.url ~ "^.*/ajax/.*$")
    	return (pass);
	}
}

/*
 * Pipe all Drupalish Streams directly to BackEnd
 */
sub pipeIfDrupalStream {
	if (req.url ~ "^/admin/content/backup_migrate/export" ||
		req.url ~ "^/system/files") {
    	return (pipe);
	}
}

/*
 * Remove all Client cookies which BackEnd doesn't use
 */
sub removeUnnecessaryDrupalishCookies {
	if (req.http.Cookie) {
	    /* Warning: Not a pretty solution */
	    /* Prefix header containing cookies with ';' */
	    set req.http.Cookie = ";" + req.http.Cookie;
	    /* Remove any spaces after ';' in header containing cookies */
	    set req.http.Cookie = regsuball(req.http.Cookie, "; +", ";");
	    /* Prefix cookies we want to preserve with one space */
	    /* 'S{1,2}ESS[a-z0-9]+' is the regular expression matching a Drupal session cookie ({1,2} added for HTTPS support) */
	    /* 'NO_CACHE' is usually set after a POST request to make sure issuing user see the results of his post */
	    set req.http.Cookie = regsuball(req.http.Cookie, ";(S{1,2}ESS[a-z0-9]+|NO_CACHE)=", "; \1=");
	    /* Remove from the header any single Cookie not prefixed with a space until next ';' separator */
	    set req.http.Cookie = regsuball(req.http.Cookie, ";[^ ][^;]*", "");
	    /* Remove any '; ' at the start or the end of the header */
	    set req.http.Cookie = regsuball(req.http.Cookie, "^[; ]+|[; ]+$", "");

	    if (req.http.Cookie == "") {
			/* If there are no remaining cookies, remove the cookie header. */
	      	unset req.http.Cookie;
	    }
	}
}
