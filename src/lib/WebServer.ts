/// <reference path="../../typings/tsd.d.ts" />
import express        = require("express");
import http           = require("http");
import bodyParser     = require("body-parser");
import url            = require("url");
import routes         = require("./../routing/index");

var engine: Function         = require("ejs-mate");
var errorHandler: Function   = require("errorhandler");
var methodOverride: Function = require("method-override");

class WebServer {

    protected host: string;
    protected port: number;
    protected app: express.Express;
    
    public constructor(host:string, port: number){
        this.host = host;
        this.port = port;
        
        this.app = express();
        
        return this;
    }

    protected configure():express.Express {

        this.app.engine('ejs', engine);
        
        this.app.set('views', __dirname + '/../views');
        this.app.set('view engine', 'ejs');
        this.app.set('view options', { layout: false });
        this.app.use(bodyParser.urlencoded({ extended: true }));
        this.app.use(bodyParser.json());
        this.app.use(methodOverride());
        this.app.use(express.static(__dirname + '/../public'));

        var env = process.env.NODE_ENV || 'development';
        if (env === 'development') {
            this.app.use(errorHandler({ dumpExceptions: true, showStack: true }));
        } 
        else if (env === 'production') {
            this.app.use(errorHandler());
        }

        this.app.get('/', routes.index);
        
        return this.app
    }
    
    public run():http.Server {
        
        var self = this;
        return this.configure().listen(this.port,this.host, function() {
            console.log("Server listening on: "+self.host+":"+self.port)
        })
    }
}

export = WebServer;