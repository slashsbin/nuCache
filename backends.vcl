############
# BackEnds #
############
include "backend.d/backend__main.vcl";


/**
 * BackEnd Chooser
 */
sub bootstrap {
    if( server.port == 80 ) {
        set req.backend = main;
    } else {
	   error 404 "UnDefined Backend";
	}
}