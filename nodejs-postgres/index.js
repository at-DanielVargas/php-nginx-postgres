const http = require('http');
const port = 8080

var srv = http.createServer((req, res) => {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('It works!');
});

console.log(`Server started [:${port}]`)
srv.listen(port)