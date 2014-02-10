/**
 * Secure Access ONLY to ACL secure List
 */
sub secureAccess {
	if( !client.ip ~ secure ) {
		error 403 "Forbidden due Secure ACL Policy";
	}
}

/**
 * Secure Access from UserAgents Provided here
 */
sub secureUA {
	if(
		req.http.User-Agent ~ "(?i)hivaBot" ||		// hivaBot/hivaBot-0.2 (http://gorgor.ir; info@gorgor.ir)
		req.http.User-Agent ~ "(?i)MJ12bot" ||		// Mozilla/5.0 (compatible; MJ12bot/v1.4.4; http://www.majestic12.co.uk/bot.php?+)
		req.http.User-Agent ~ "(?i)AhrefsBot"		// Mozilla/5.0 (compatible; AhrefsBot/5.0; +http://ahrefs.com/robot/)
	 ) {
		error 403 "Forbidden due Secure UA Policy";
	}
}
