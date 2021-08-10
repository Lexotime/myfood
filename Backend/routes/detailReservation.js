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

// La creation des routes ..................................................

router.get('/', (request,response)=>{
    db.query('SELECT * FROM detailReservations', (err,result)=>{
        if(err) throw err
        response.send(result)
    })
})

router.post('/', (request,response)=>{
    let values = [
        [request.body.reservation_id,request.body.menu_id,request.body.quantite]
    ]
    db.query('INSERT INTO detailReservations (reservation_id,menu_id,quantite) VALUES ?', [values], (err)=>{
        if(err) response.send(false)
        else response.send(true)
    })
})
// ---------------------------------------------------
router.get('/:numero', (request,response)=>{
    let values = [
        [request.params.numero]
    ]
    db.query('SELECT * FROM detailReservations WHERE reservation_id = ?', [values], (err,result)=>{
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
    db.query('DELETE FROM detailReservations WHERE reservation_id = ?', [values], (err)=>{
        if(err) response.send(false)
        else response.send(true)
    })
})
// ---------------------------------------------------

// Exportation de la route ................................................

export default router