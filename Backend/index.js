// Importation des packages ........................................

import express from 'express'
import bodyParser from 'body-parser'
import clientRoutes from './routes/client.js'
import commandeRoutes from './routes/commande.js'
import detailCommandeRoutes from './routes/detailCommande.js'
import detailReservationRoutes from './routes/detailReservation.js'
import livreurRoutes from './routes/livreur.js'
import menuRoutes from './routes/menu.js'
import reservationRoutes from './routes/reservation.js'
import restaurantRoutes from './routes/restaurant.js'

// Creation de l'application ........................................

const app = express()
const PORT =  6000

// Activation des modules ...........................................

app.use(bodyParser.json())
app.use('/client', clientRoutes)
app.use('/detailCommande', detailCommandeRoutes)
app.use('/detailReservation', detailReservationRoutes)
app.use('/livreur', livreurRoutes)
app.use('/menu', menuRoutes)
app.use('/commande', commandeRoutes)
app.use('/reservation', reservationRoutes)
app.use('/restaurant', restaurantRoutes)

// Lancement de l'application .......................................

app.listen(PORT, ()=> console.log(`Le serveur fonctionne à l'adresse http://localhost:${PORT}`))

// Fin du Programme ...................................................