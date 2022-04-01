const express = require('express');
const port = process.env.PORT || 8080;
const app = express();

app.get('/', (req, res) => {
   res.send('Hello World from Dockerized app!');
});

app.listen(port, () => { console.log('Our App Is Up And Running!'); });
module.exports = app
