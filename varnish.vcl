include "backends.vcl";
sub vcl_recv {
    call bootstrap;
}

include "modules.vcl";