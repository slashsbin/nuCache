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
