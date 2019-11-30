const _=require('lodash');
const express=require('express');
const http = require('http');
const WebSocket = require('ws');
const path=require('path');
var url = require('url');
const fs=require('fs');
let cors=require('cors');
const port=3000;
var bodyParser= require('body-parser');

let app=express();
app.use(bodyParser.json());
app.use(cors());
app.use(bodyParser.urlencoded({ extended: true, limit: "50mb" }));

app.get('/',(req,res)=>{
    const spawn = require("child_process").spawn;

    const pythonProcess = spawn('python',["./recommendationSystem/recommendation_Data.py"]);

    pythonProcess.stdout.on('data', (data) => {
        res.send(data);
    });

})

//function module that will be calling recommendation --collaborative filtering
app.get('/get_recommendation',(req,res)=>{

})

app.listen(port,()=>{
    console.log('server is high on port ',port);
 })
