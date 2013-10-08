/*
 * Module Custom Error Page
 *
 * Depends on Standard VMod
 */

#import std;

########[ RECV ]################################################################
sub vcl_recv {
	# Test Error Page
	#error 503;
}

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
    
    Powered By nuCache v"} + std.fileread("/etc/varnish/VERSION") + {" & <3
-->
<html>
<head>
    <title>nuCache :: "} + obj.status + {"</title>
    <style>
        * { transition: color 500ms, background-color 1s; margin: 0; padding: 0; }
        body { font-family: monospace; font-size: 16pt; background-repeat: repeat; background-image: url('data:image/png;base64,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'); }
        .symbol { font-family: serif; font-weight: bold; color: purple; }
        h1 { padding: 20px 40px; font-size: 26pt; background-color: #000; color: #FFF; }
        h1 .symbol { color: #FFF; font-size: 40pt; }
        h1:hover .symbol { color: purple; }
		#colorBarz { overflow: auto; }
        .colorBar { height: 10px; float: left; width: 20%; }
        #colorBar1 { background-color: #CCC; } #colorBar2 { background-color: #888; } #colorBar3 { background-color: #444; } #colorBar4 { background-color: #888; } #colorBar5 { background-color: #CCC; }
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
    <h1><span class="symbol">&#9888;</span> "} + obj.response + {"</h1>

	<div id="colorBarz">
    <div class="colorBar" id="colorBar1"></div><div class="colorBar" id="colorBar2"></div><div class="colorBar" id="colorBar3"></div><div class="colorBar" id="colorBar4"></div><div class="colorBar" id="colorBar5"></div>
	</div>
    
    <p id="errorMsg">
    <b>Something is amiss</b>,<br />
    <span class="symbol">&nu;</span>Cache Connection attempt to BE::"} + req.backend + {" was replied with NET::HTTP:"} + obj.status + {" header. We are investigating and resolving the issue this very second, and hope to have things back very soon.<br /><br />
    We very much appreciate your patience, Please try again in few minutes.
    </p>
    
    <hr />
    <div id="kvz">
    <h3>Guru Meditation</h3>
    <div class="kv"><span class="k">GuruMeditationXID:</span><span class="v">"} + req.xid + {"</span></div>
    <div class="kv"><span class="k">Status:</span><span class="v">"} + obj.status + {"</span></div>
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
    <div id="footer"><span class="symbol">&nu;</span>Cache v"} + std.fileread("/etc/varnish/VERSION") + {"</div>
</body>
</html>"};

    return (deliver);
}

