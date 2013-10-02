/*
 * Health Check
 * RAW
 */
probe rawhealthcheck_main {
    .url = "/";
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
    .connect_timeout = 0.7s;
    .first_byte_timeout = 60s;
    .between_bytes_timeout = 60s;
    .probe = rawhealthcheck_main;
}
