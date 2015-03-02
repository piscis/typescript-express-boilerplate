import WebServer = require('./lib/WebServer');

var app = new WebServer("0.0.0.0", 3003)
app.run()