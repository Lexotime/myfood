// Importation des modules ...............................................

import express from 'express'
import mysql from 'mysql'

// Creation des variables ................................................

const router = express.Router()
const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "myfood"
})
db.connect((err) =>{
    if(err) throw err
    console.log("Connexion DB: OK")
})

// Les routes disponibles .................................................

// ---------------------------------------------------
router.get('/', (request,response)=>{
    db.query('SELECT * FROM clients', (err,result)=>{
        if(err) throw err
        response.send(result)
    })
})
// ---------------------------------------------------

// ---------------------------------------------------
router.post('/', (request,response)=>{
    let values = [
        [request.body.numTel,request.body.mail,request.body.username,request.body.password,request.body.prenom,request.body.nom,request.body.adresse]
    ]
    db.query('INSERT INTO clients (numeroTel,mail,username,password,prenom,nom,adresse) VALUES ?',[values],(err)=>{
        if(err) response.send(false)
        else response.send(true)
    })
})
// ---------------------------------------------------

// ---------------------------------------------------
router.get('/:numero', (request,response)=>{
    let values = [
        [request.params.numero]
    ]
    db.query('SELECT * FROM clients WHERE numeroTel = ?', [values], (err,result)=>{
        if(err) throw err
        response.send(result)
    })
})
// ---------------------------------------------------

// ---------------------------------------------------
router.delete('/:numero', (request,response)=>{
    let values = [
        [request.params.numero]
    ]
    db.query('DELETE FROM clients WHERE numeroTel = ?', [values], (err)=>{
        if(err) response.send(false)
        else response.send(true)
    })
})
// ---------------------------------------------------


// Exportation de la route ................................................

export default router