/*
 * Module Custom Error Page
 *
 * Depends on Standard VMod
 */

#import std;

########[ ERROR ]###############################################################
sub vcl_error {
    set obj.http.Content-Type = "text/html; charset=utf-8";
    set obj.http.Retry-After = "5";
    synthetic {"<!DOCTYPE html>
<!--

               ..|'''.|                 '||             
    .... ... .|'     '   ....     ....   || ..     .... 
     '|.  |  ||         '' .||  .|   ''  ||' ||  .|...||
      '|.|   '|.      . .|' ||  ||       ||  ||  ||     
       '|     ''|....'  '|..'|'  '|...' .||. ||.  '|...'
    
    Varnish-Cache via nuCache v$Id$

-->
<html>
<head>
    <title>nuCache :: "} + obj.status + " " + obj.response + {"</title>
    <style>
        * { transition: color 0.5s, background-color 1s; margin: 0; padding: 0; }
        body { font-family: monospace; font-size: 16pt; }
        .symbol { font-family: serif; font-weight: bold; }
        h1 { padding: 20px; font-size: 26pt; background-color: #000; color: #FFF; }
        h1 .symbol { color: #FFF; font-size: 40pt; }
        h1:hover .symbol { color: purple; }
        .colorBar { height: 10px; }
        #colorBar1 { background-color: #333; } #colorBar2 { background-color: #666; } #colorBar3 { background-color: #999; } #colorBar4 { background-color: #CCC; }
        .colorBar:hover { background-color: purple !important; }
        #kvz, #errorMsg { padding: 40px; }
        #errorMsg:hover .symbol { color: purple !important; }
        #kvz .kv span { text-shadow: 0px 1px 0px #CCC; }
        #kvz .k { color: #444; }
        #kvz .v { margin: 0 10px; }
        #kvz .kv:hover .k { color: purple; }
        #footer { float: right; margin: 0 40px; }
        #footer:hover .symbol { color: purple !important; }
    </style>
</head>
<body>
    <h1><span class="symbol">&#9888;</span> Error "} + obj.status + {"</h1>
    
    <div class="colorBar" id="colorBar1"></div><div class="colorBar" id="colorBar2"></div><div class="colorBar" id="colorBar3"></div><div class="colorBar" id="colorBar4"></div>
    
    <p id="errorMsg">
    <b>Failed to serve the Request</b>,<br />
    <span class="symbol">&nu;</span>Cache Connection attempt to BE::"} + req.backend + {" was UnSuccessful with reply NET::HTTP:"} + obj.status + {".
    Please try again in few minutes.
    </p>
    
    <hr />
    <div id="kvz">
    <h3>Guru Meditation</h3>
    <div class="kv"><span class="k">GuruMeditationXID:</span><span class="v">"} + req.xid + {"</span></div>
    <div class="kv"><span class="k">Response:</span><span class="v">"} + obj.response + {"</span></div>
    <div class="kv"><span class="k">Restart:</span><span class="v">"} + req.restarts + {"</span></div>
    <div class="kv"><span class="k">TTL:</span><span class="v">"} + obj.ttl + {"</span></div>
    <div class="kv"><span class="k">LastUse:</span><span class="v">"} + obj.lastuse + {"</span></div>
    <div class="kv"><span class="k">Proto:</span><span class="v">"} + obj.proto + {"</span></div>
    <div class="kv"><span class="k">CIP:</span><span class="v">"} + client.ip + {"</span></div>
    <div class="kv"><span class="k">GZip:</span><span class="v">"} + req.can_gzip + {"</span></div>
    <div class="kv"><span class="k">SIP:</span><span class="v">"} + server.ip + {"</span></div>
    <div class="kv"><span class="k">Method:</span><span class="v">"} + req.request + {"</span></div>
    <div class="kv"><span class="k">URL:</span><span class="v">"} + req.url + {"</span></div>
    <div class="kv"><span class="k">Timestamp:</span><span class="v">"} + now + {"</span></div>
    <div class="kv"><span class="k">Seed:</span><span class="v">"} + std.random(10000,100000000) + {"</span></div>
    </div>
    
    <hr />
    <div id="footer">Varnish-Cache Server via <span class="symbol">&nu;</span>Cache</div>
</body>
</html>"};

    return (deliver);
}

