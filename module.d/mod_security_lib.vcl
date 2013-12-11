/**
 * Secure Access ONLY to ACL secure List
 */
sub secureAccess {
	if( !client.ip ~ secure ) {
		error 403 "Forbidden due Secure ACL Policy";
	}
}

