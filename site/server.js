var express = require("express");
var mysql = require('mysql');
var http = require('http');
var session = require('express-session')
var https = require('http');
var request = require('request');

var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : '',
  database : 'html'
});
var app = express();
app.set('port', (process.env.PORT || 3000));
app.use(express.static(__dirname));
app.set('views', __dirname);
app.engine('html', require('ejs').renderFile);


connection.connect(function(err){
if(!err) {
    console.log("Database is connected ... nn");    
} else {
    console.log("Error connecting database ... nn");    
}
});

// page des photos
app.get("/getPhotos", findPhotos, renderPhotosPage);

// page de connection
app.get("/connexion", function(req, res){
    var login = req.query.login;
    var password = req.query.password;
    console.log('login : ',login);
    console.log('password : ',password);
    // Connection à la BDD + enregistrement de l'ID en session
    connection.query('SELECT * from users where identifiant=? and mdp =?',[login, password], function(err, rows) {
        console.log('retour',rows);
        if (!err && rows!=""){
            req.user = rows[0];
            req.error = false;
            session.id=req.user.idusers;
            console.log(req.user);
            console.log(req.error);
            console.log(session.id);
            // Appel de getPhotos + ID
            request('http://localhost:3000/getPhotos', function (error, response, body) {
                if (!error && response.statusCode == 200) {
                    console.log(body) // Print the web page.
                    
                 }
            });
        }else{
            console.log('Error while performing Query.');   
            //Renvoie de la même page
            req.error = true;
            res.render('Acceuil.ejs');
        }
    });
});

// find photos in database
function findPhotos(req, res, next) {
    connection.query('SELECT * from photos where idusers=?',[session.id], function(err, rows) {
        if (!err){
            console.log('The solution is: ', rows);
            req.photos = rows;
            return next();
        }else
            console.log('Error while performing Query.');         
    });
}

// Renvoie de la page photos
function renderPhotosPage(req, res) {
    res.render('Photos.ejs', {
        photos: req.photos
    });
    console.log('page des photos');
    console.log('id : ',  session.id)
}


/* home page. */
app.get('/', function(req, res) {
  res.render('Acceuil.ejs');
});

/* page erreur */
app.get('*', function(req, res) {
  res.sendfile('Error.html');
});

app.listen(3000);