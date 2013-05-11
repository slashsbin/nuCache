/**
 * Removes cookies from static files request
 * and normalizes the request URL
 */
sub removeCookiesFromStaticsRxKeepDrupals {
    if (req.url !~ "^/system/files/private/.*$" &&
        req.url ~ "^/[^?]+\.(jpeg|jpg|png|gif|ico|js|css|txt|gz|zip|lzma|bz2|tgz|tbz|html|htm)(\?.*|)$") {
        unset req.http.cookie;
        set req.url = regsub(req.url, "\?.*$", "");
    }
}

/**
 * Removes cookies from static files response
 */
sub removeCookiesFromStaticsTxKeepDrupals {
    if (req.url !~ "^/system/files/private/.*$" &&
        req.url ~ "^/[^?]+\.(bmp|bz2|css|doc|eot|flv|gif|gz|ico|jpeg|jpg|js|less|mp[34]|pdf|png|rar|rtf|swf|tar|tgz|txt|wav|woff|xml|zip)(\?.*)?$") {
        unset beresp.http.set-cookie;
    }
}