/**
 * Pass if Request is .php or .php5
 */
sub passIfIsPHP {
    if( req.url ~ "\.(php|php5)" ) {
        return (pass);
    }
}