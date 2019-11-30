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
mongoose.connect(
    "mongodb://localhost:27017/bookSaat",
    { useNewUrlParser: true, useUnifiedTopology: true },
    () => {
        console.log("Connected to DB");
    }
);

const port=process.env.PORT;
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
    console.log("alex");
    // const data = req.body;
    // res.send(data);
    // //console.log(data);
});

app.listen(port,()=>{
    console.log('server is high on port ',port);
 })
