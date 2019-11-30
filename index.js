const _ = require('lodash');
const express = require('express');
const http = require('http');
const WebSocket = require('ws');
const path = require('path');
var url = require('url');
const fs = require('fs');
const mongoose = require("mongoose");
const dotenv = require("dotenv");
let cors = require('cors');
const Books = require("./model/books");

mongoose.connect(
    "mongodb://localhost:27017/bookSaat",
    { useNewUrlParser: true, useUnifiedTopology: true },
    () => {
        console.log("Connected to DB");
    }
);

const port = 8080;
var bodyParser = require('body-parser');

let app = express();
app.use(bodyParser.json());
app.use(cors());
app.use(bodyParser.urlencoded({ extended: true, limit: "50mb" }));

app.get('/', (req, res) => {
    const spawn = require("child_process").spawn;

    const pythonProcess = spawn('python', ["./recommendationSystem/recommendation_Data.py"]);

    pythonProcess.stdout.on('data')
});

let recommend = [];
Books.find({}, (err, docs) => {
    if (err) return;
    recommend = docs;
});


app.get("/recommended", async (req, res) => {
    res.send(recommend);
});

let science_data = [];
let drama_data = [];
let mix_data = [];

Books.find({ "category.catName": "Science" }, (err, docs) => {
    science_data = docs;
    // console.log(science_data);
});

Books.find({ "category.catName": "Fiction" }, (err, docs) => {
    drama_data = docs;
    // console.log(drama_data);
});


//function module that will be calling recommendation --collaborative filtering
app.get('/recommended', (req, res) => {
    const spawn = require("child_process").spawn;

    const pythonProcess = spawn('python', ["./recommendationSystem/recommendation_Data.py"]);

    pythonProcess.stdout.on('data')
});

app.get('/exchange', (req, res) => {
    let a = _.includes(req.query.q.toLowerCase(), 'stephen'); 
    if (a) { 
        res.send(science_data);
    }
});

let c_universe = false;
let c_mistakes = false;
let c_mix = false;
app.get('/search', (req, res) => {
    console.log(req.query.q);
    let a = _.includes(req.query.q, 'universe');
    let b = _.includes(req.query.q, 'revolution');
    console.log(a);

    if (a == true) {
        recommend = science_data;
        res.send(science_data);
        

    }
    if (b == true) {
        recommend = drama_data;
        res.send(drama_data);
    }
    if (c_universe && c_mistakes) {
        !c_mix
    }

    if (c_universe) {
        res.send(science_data);
    }
    if (c_mistakes) {
        res.send(drama_data);
    }
    if (c_mix) {
        mix_data.push(science_data);
        mix_data.push(drama_data);
        console.log(mix_data);
        res.send(mix_data);
    }

});


app.get('/authId', async (req, res) => {
    const authId = await Books.find({ authId: req.query.q }, (err, docs) => {
        if (err) return;
        // console.log(docs);
        res.json(docs);
    });
});

app.listen(port, () => {
    console.log('server is high on port ', port);
});
