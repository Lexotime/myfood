// Importation des modules ...............................................

import express from 'express'
import mysql from 'mysql'

// Creation des variables .....................................

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

// Les routes disponibles ..............................................

router.get('/', (request,response)=>{
    db.query('SELECT * FROM commandes', (err,result)=>{
        if(err) throw err
        response.send(result)
    })
})

router.post('/', (request,response)=>{
    let values = [
        [request.body.numCommande,request.body.client_id,request.body.etatCommande,request.body.etatLivraison,request.body.livreur_id]
    ]
    db.query('INSERT INTO commandes (numCommande,client_id,etatCommande,etatLivraison,livreur_id) VALUES ?', [values], (err)=>{
        if(err) response.send(false)
        else response.send(true)
    })
})

// ---------------------------------------------------
router.get('/:numero', (request,response)=>{
    let values = [
        [request.params.numero]
    ]
    db.query('SELECT * FROM commandes WHERE numCommande = ?', [values], (err,result)=>{
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
    db.query('DELETE FROM commandes WHERE numCommande = ?', [values], (err)=>{
        if(err) response.send(false)
        else response.send(true)
    })
})
// ---------------------------------------------------

// Exportation de la route ................................................

export default router