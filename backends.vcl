############
# BackEnds #
############
include "backend.d/backend__main.vcl";
include "backend.d/backend__d7.vcl";


/**
 * BackEnd Chooser
 */
sub bootstrap {
	if( server.port == 6081 ) {
	   set req.backend = main;
	} elseif ( server.port == 7081 ) {
		set req.backend = d7;
	} else {
	   error 400 "UnSupported Backend";
	}
}