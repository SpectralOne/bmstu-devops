var express = require("express");
var app = express();

app.use(express.static('/home/user/dist/public/pages'));
// app.use(express.static(__dirname + '/public/css'));

app.get('/', function (_req, res) {
    res.sendFile('index.html', { root: '/home/user/dist'});
});

app.listen(80);

console.log("Running at Port 80");
