Variable availability in VCL
============================
https://www.varnish-software.com/static/book/VCL_functions.html#variable-availability-in-vcl

| Variable | recv | fetch | pass | miss | hit | error | deliver | pipe | hash |
| :------: | :--: | :---: | :--: | :--: | :-: | :---: | :-----: | :--: | :--: |
| req.*    |  RW  |   RW  |  RW  |  RW  |  RW |   RW  |    RW   |  RW  |   RW |
| bereq.*  |  --  |   RW  |  RW  |  RW  |  -  |   -   |    -    |  RW  |   -  |
| obj.hits |  --  |   -   |  --  |  --  |  R  |   -   |    R    |  --  |   -  |
| obj.ttl  |  --  |   -   |  --  |  --  |  RW |   RW  |    -    |  --  |   -  |
| obj.grace|  --  |   -   |  --  |  --  |  RW |   -   |    -    |  --  |   -  |
| obj.*    |  --  |   -   |  --  |  --  |  R  |   RW  |    -    |  --  |   -  |
| beresp.* |  --  |   RW  |  --  |  --  |  -  |   -   |    -    |  --  |   -  |
| resp.*   |  --  |   -   |  --  |  --  |  -  |   RW  |    RW   |  --  |   -  |
| client.* |  RW  |   RW  |  RW  |  RW  |  RW |   RW  |    RW   |  RW  |   RW |
| server.* |  RW  |   RW  |  RW  |  RW  |  RW |   RW  |    RW   |  RW  |   RW |

