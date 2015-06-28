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
		req.http.User-Agent ~ "(?i)Exabot" ||		// Mozilla/5.0 (compatible; Exabot/3.0; +http://www.exabot.com/go/robot)
		req.http.User-Agent ~ "(?i)magpie" ||		// magpie-crawler/1.1 (U; Linux amd64; en-GB; +http://www.brandwatch.net)
		req.http.User-Agent ~ "(?i)GrapeshotCrawler" ||		// Mozilla/5.0 (compatible; GrapeshotCrawler/2.0; +http://www.grapeshot.co.uk/crawler.php)
		req.http.User-Agent ~ "(?i)WBSearchBot" ||		// Mozilla/5.0 (compatible; WBSearchBot/1.1; +http://www.warebay.com/bot.html)
		req.http.User-Agent ~ "(?i)SISTRIX" ||		// Mozilla/5.0 (compatible; SISTRIX Crawler; http://crawler.sistrix.net/)
		req.http.User-Agent ~ "(?i)parsijoo" ||		// Mozilla/5.0 (compatible; parsijoo-crawler; +http://www.parsijoo.ir/; ehsan.mousakazemi@gmail.com)
		req.http.User-Agent ~ "(?i)BLEXBot" ||		// Mozilla/5.0 (compatible; BLEXBot/1.0; +http://webmeup-crawler.com/)
		req.http.User-Agent ~ "(?i)hivaBot" ||		// hivaBot/hivaBot-0.2 (http://gorgor.ir; info@gorgor.ir)
		req.http.User-Agent ~ "(?i)MJ12bot" ||		// Mozilla/5.0 (compatible; MJ12bot/v1.4.4; http://www.majestic12.co.uk/bot.php?+)
		req.http.User-Agent ~ "(?i)AhrefsBot"		// Mozilla/5.0 (compatible; AhrefsBot/5.0; +http://ahrefs.com/robot/)
	 ) {
		error 403 "Forbidden due Secure UA Policy";
	}
}

/**
 * Secure Access from GOOD UserAgents Provided here
 */
sub secureGoodUA {
	if(
		// Google
		req.http.User-Agent ~ "(?i)Googlebot" ||		// Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)
		req.http.User-Agent ~ "(?i)GoogleApps script" ||		// Mozilla/5.0 (compatible; GoogleApps script; +http://script.google.com/bot.html)
		req.http.User-Agent ~ "(?i)Googlebot-Image" ||		// Googlebot-Image/1.0

		// Bing,MSN
		req.http.User-Agent ~ "(?i)bingbot" ||		// Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)
		req.http.User-Agent ~ "(?i)msnbot-media" ||		// msnbot-media/1.1 (+http://search.msn.com/msnbot.htm)
		req.http.User-Agent ~ "(?i)msnbot" ||		// msnbot/0.01 (+http://search.msn.com/msnbot.htm)

		// Yandex
		req.http.User-Agent ~ "(?i)YandexBot" ||		// Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)
		req.http.User-Agent ~ "(?i)YandexImages" ||		// Mozilla/5.0 (compatible; YandexImages/3.0; +http://yandex.com/bots)

		// Others
		req.http.User-Agent ~ "(?i)ia_archiver" ||		// ia_archiver (+http://www.alexa.com/site/help/webmasters; crawler@alexa.com)
		req.http.User-Agent ~ "(?i)Ezooms"		// Mozilla/5.0 (compatible; Ezooms/1.0; help@moz.com)
	 ) {
		error 403 "Forbidden due Secure Good UA Policy";
	}
}

