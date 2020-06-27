const express = require('express');
const app = express();
const cors = require('cors');
const http = require('http');
const baseUrl = 'http://localhost:8983/solr/demo/select?q='
var result;

const corsOptions = {
  origin: 'http://localhost:4200',
  optionsSuccessStatus: 200 
}
app.use(cors(corsOptions));


app.route('/api/query:track_name_si').get((req, resultToSend) => {
  var track_name_si = req.params['track_name_si'];
  //substring deletes first character of the string so the ":" will go away
  track_name_si = track_name_si.substring(1)
  var track_name_siSplitted = track_name_si.split('+');
  var keyword = track_name_siSplitted[0];
  var type = track_name_siSplitted[1];
  

  //http request to the solr API
  http.get(`${baseUrl}${type}:${keyword}`, (res) => {
    res.setEncoding('utf8');
    let body = "";
    res.on("data", data => {
      body += data;
    });
    res.on("end", () => {
      body = JSON.parse(body);
      resultToSend.send({body});
      console.log(`[UPDATE]: results based on ${type} search just transfered to the frontend app`);
    });
  });
});

app.route('/api/sameCategoryBoolean:track_name_si').get((req, resultToSend) => {
  var track_name_si = req.params['track_name_si'];
  //substring deletes first character of the string so the ":" will go away
  track_name_si = track_name_si.substring(1)
  var track_name_siSplitted = track_name_si.split('+');
  var query = track_name_siSplitted[0];
  var type = track_name_siSplitted[1];

  //encode the url with browser standards for every case
  var encodedQuery = encodeURI(query);
  
  //http request to the solr API
  http.get(`${baseUrl}${encodedQuery}`, (res) => {
    res.setEncoding('utf8');
    let body = "";
    res.on("data", data => {
      body += data;
    });
    res.on("end", () => {
      body = JSON.parse(body);
      resultToSend.send({body});
      console.log(`[UPDATE]: results based on boolean combination of ${type} search just transfered to the frontend app`);
    });
  });
});


app.route('/api/differentCategoryBoolean:track_name_si').get((req, resultToSend) => {
  var query = req.params['track_name_si'];
  //substring deletes first character of the string so the ":" will go away
  query = query.substring(1)

  //encode the url with browser standards for every case
  var encodedQuery = encodeURI(query);
  
  console.log(query);
  console.log(`${baseUrl}${encodedQuery}`);

  //http request to the solr API
  http.get(`${baseUrl}${encodedQuery}`, (res) => {
    res.setEncoding('utf8');
    let body = "";
    res.on("data", data => {
      body += data;
    });
    res.on("end", () => {
      body = JSON.parse(body);
      resultToSend.send({body});
      console.log(`[UPDATE]: results based on boolean combination of different types of search just transfered to the frontend app`);
    });
  });
});



//the server listens here
app.listen(8000, () => {
  console.log('[UPDATE]:Server now listens for incoming connections at port:8000');
});
