const _=require('lodash');
const express=require('express');
const http = require('http');
const WebSocket = require('ws');
const path=require('path');
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
var bodyParser= require('body-parser');

let app=express();
app.use(bodyParser.json());
app.use(cors());
app.use(bodyParser.urlencoded({ extended: true, limit: "50mb" }));
const spawn = require("child_process").spawn;

const pythonProcess = spawn('python',["./recommendation_Data.py"]);

pythonProcess.stdout.on('data', (data) => {
    console.log(data);
});
app.use(express.json());
app.get('/',(req,res)=>{
    res.send('Hey,I am called');
})
app.get("/recommended", async (req, res)=>{ 
    const book = await Books.find({}, (err, docs) => { 
        if (err) return;
        console.log(docs);
        res.json(docs);
    });
});

//function module that will be calling recommendation --collaborative filtering
app.get('/search', (req, res) => {
    console.log(req.query.q);
    res.send(req.query.q);
    
});

app.get('/authId', async (req, res) => { 
    const authId = await Books.find({ authId: req.query.q }, (err, docs) => {
        if (err) return;
        console.log(docs);
        res.json(docs);
    });
});

app.listen(port,()=>{
    console.log('server is high on port ',port);
 })
