import express from 'express'
import { setAuthRoutes } from './routes/v1/authRoutes'

const app = express()
const PORT = 3001

app.use(express.json())
setAuthRoutes(app)

app.listen(PORT, "0.0.0.0", () => {
    console.log(`Server is running on port ${PORT}`)
})