var express     = require('express');
var morgan      = require('morgan');

var app = express();
var server = require('http').Server(app);
port = process.env.PORT || 9999;

app.get('/', (req, res) => {
    process.exit(1); // Forces Node.js to die immediately!
});

app.get('/ping', (req, res) => {
    res.send("Pong!");
});

app.post('/ping', (req, res) => {
    res.send("POST: Pong!");
});

// use morgan to log requests to the console
app.use(morgan('dev'));

server.listen(port);
console.log('App running at http://localhost:' + port);
