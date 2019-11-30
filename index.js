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

    pythonProcess.stdout.on('data')
})


//function module that will be calling recommendation --collaborative filtering
app.get('/recommended',(req,res)=>{
    const spawn = require("child_process").spawn;

    const pythonProcess = spawn('python',["./recommendationSystem/recommendation_Data.py"]);

    pythonProcess.stdout.on('data')
})
let c_universe=false;
let c_mistakes=false;
let c_mix=false;
app.get('/search',(req,res)=>{
   console.log(req.query.q);
   let a = _.includes(req.query.q,'universe');
   let b= _.includes(req.query.q,'revolution');

   if (a==true){
       !c_universe;
   }
   if(b==true){
       !c_mistakes;
   }
   if ( c_universe && c_mistakes ){
       !c_mix
   }

   if (c_universe){
       res.send(science_data);
   }
   if (c_mistakes){
       res.send(drama_data);
   }
   if(c_mix){
       res.send(mix_data);
   }







   console.log(a);





})

app.listen(port,()=>{
    console.log('server is high on port ',port);
 })
