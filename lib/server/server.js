const express=require('express');
const app=express();
const jwt=require('jsonwebtoken');
const jwt_decode = require('jwt-decode');
const bcrypt=require('bcrypt');
const mongoose=require('mongoose');
async function connectDB(){
    await mongoose.connect("mongodb+srv://aniket_199:aniket.1999@todo.6is7s.mongodb.net/Zep?retryWrites=true&w=majority",{ useNewUrlParser: true, useUnifiedTopology: true, useCreateIndex:true });
    console.log("connectDB");
}
connectDB()
app.use(express.json({extended:false}));
var schema=new mongoose.Schema({first_name:"String",last_name:"String",email:"String",mobileno:"String",password:"String"});
var schema1=new mongoose.Schema({meal_name:"string",meal_info:"string",price:"string",type:"string"});
var User=mongoose.model("User",schema);
var Meal=mongoose.model("Meal",schema1);
app.post('/signup',async(req,res)=>{
    var {first_name,last_name,mobileno,email,password}=req.body;
    var salt=await bcrypt.genSalt();
    password=await bcrypt.hash(password,salt);
    let user=await User.findOne({mobileno});
    if(user){
        return res.json({msg:"User already registered"});
    }
    user=new User({first_name,last_name,mobileno,email,password});
    console.log(user);
    await user.save();
    var token=jwt.sign({id:user.id},"password");
    res.json({token:token,msg:'User registered'})
    // res.send('User registered');
})
app.post('/login',async(req,res)=>{
    var {mobileno,password}=req.body;
    console.log(mobileno,password);
    let user=await User.findOne({mobileno});
    
    // console.log(auth);
    if(!user){
        return res.json({msg:"Email Incorrect"});
    }
    var auth=await bcrypt.compare(password,user.password);
    if(!auth){
        return res.json({msg:"Password Incorrect"});
    }
    else{
        var token=jwt.sign({id:user.id},"password");
        var id=user._id
        return res.json({token:token,id:id});
        // res.json({msg:"Login successful"})
    }
})
app.post('/menu',async(req,res)=>{
    var {meal_name,meal_info,price,type}=req.body;
    console.log(meal_name,meal_info,price,type);
    let meal=new Meal({
        meal_name,
        meal_info,
        price,
        type
    });
    console.log(meal);
    if(await meal.save()){
        res.json({msg:"Saved to database"});
    }
    else{
        res.json({msg:"Not Saved to database"});
    }
})
app.get('/display',async (req,res)=>{
    let hist=await Meal.find();
    var meal_name=[];
    var meal_info=[];
    var price=[];
    for (let i = 0; i < hist.length; i++) {
        if(hist[i].type=="Main Course"){
            meal_name.push(JSON.stringify(hist[i].meal_name));
            meal_info.push(JSON.stringify(hist[i].meal_info));
            price.push(JSON.stringify(hist[i].price));
        }
    }
    for (let i = 0; i < hist.length; i++) {
        if(hist[i].type=="Extra"){
            meal_name.push(JSON.stringify(hist[i].meal_name));
            meal_info.push(JSON.stringify(hist[i].meal_info));
            price.push(JSON.stringify(hist[i].price));
        }
    }
    res.send({meal_name:meal_name,meal_info:meal_info,price:price})
})
app.get('/maincourse',async (req,res)=>{
    let hist=await Meal.find({type:"Main Course"});
    var meal_name=[];
    var meal_info=[];
    var price=[];
    for (let i = 0; i < hist.length; i++) {
        meal_name.push(JSON.stringify(hist[i].meal_name));
        meal_info.push(JSON.stringify(hist[i].meal_info));
        price.push(JSON.stringify(hist[i].price));
    }
    res.send({meal_name:meal_name,meal_info:meal_info,price:price})
})
app.get('/extra',async (req,res)=>{
    let hist=await Meal.find({type:"Extra"});
    var meal_name=[];
    var meal_info=[];
    var price=[];
    for (let i = 0; i < hist.length; i++) {
        meal_name.push(JSON.stringify(hist[i].meal_name));
        meal_info.push(JSON.stringify(hist[i].meal_info));
        price.push(JSON.stringify(hist[i].price));
    }
    res.send({meal_name:meal_name,meal_info:meal_info,price:price})
})
app.post('/personal_info',async (req,res)=>{
    var {token}=req.body;
    var decoded = jwt_decode(token,true);
    var id=decoded.id;
    let user=await User.findOne({_id:id});
    var full_name="";
    console.log(decoded,user);
    if(parseInt(user._id)==parseInt(id)){
        full_name=user.first_name[0]+user.last_name[0];
        console.log(full_name);
        res.json({msg:user.first_name,msg1:full_name,msg2:user.email})
    }
})
app.listen(3000,()=>console.log("You are listening to port 3000"));