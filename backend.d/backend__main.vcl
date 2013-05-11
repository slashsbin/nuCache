/*
 * Health Check
 * RAW
 */
probe rawhealthcheck_main {
   .request =
      "GET / HTTP/1.1"
      "Host: 127.0.0.1:80"
      "Connection: close";
   .interval = 60s;
   .timeout = 0.3 s;
   .window = 8;
   .threshold = 3;
   .initial = 3;
   .expected_response = 200;
}

/**
 * BackEnd Main
 * Default Main Backend
 * Port 80
 */
backend main {
    .host = "127.0.0.1";
    .port = "8080";
    .probe = rawhealthcheck_main;
}