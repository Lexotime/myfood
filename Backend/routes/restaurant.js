// Importation des modules ...............................................

import express from 'express'
import mysql from 'mysql'

// Creation de la variable des routes .....................................

const router = express.Router()
const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "myfood"
})
db.connect((err)=>{
    if(err) throw err
    console.log("Connexion DB: OK")
})

// La creation des routes .................................................

router.get('/', (request,response)=>{
    db.query('SELECT * FROM restaurants', (err,result)=>{
        if(err) throw err
        response.send(result)
    })
})

router.post('/', (request,response)=>{
    let values = [
        [request.body.numTel,request.body.mail,request.body.username,request.body.password,request.body.nomResto,request.body.adresse,request.body.ouverture,request.body.fermeture,request.body.etoile,request.body.logo]
    ]
    db.query('INSERT INTO clients (numeroTel,mail,username,password,nomResto,adresse,heureOuverture,heureFermeture,nombreEtoile,logo) VALUES ?',[values],(err)=>{
        if(err) response.send(false)
        else response.send(true)
    })
})

// ---------------------------------------------------
router.get('/:numero', (request,response)=>{
    let values = [
        [request.params.numero]
    ]
    db.query('SELECT * FROM restaurants WHERE numeroTel = ?', [values], (err,result)=>{
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
    db.query('DELETE FROM restaurants WHERE numeroTel = ?', [values], (err)=>{
        if(err) response.send(false)
        else response.send(true)
    })
})
// ---------------------------------------------------

// Exportation de la route ................................................

export default router