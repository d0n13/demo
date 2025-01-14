import { Router } from 'express'
import { authenticateToken, checkPrivileges } from '../../middleware/authMiddleware'
import { Privilege } from '../../models/userModel'
import LoginAPI from '../../api/login'
import api from '../../api/forgot'
import VersionAPI from '../../api/version'

const router = Router()

export function setAuthRoutes(app: any) {
    app.use('/api/v1', router)
    
    router.post('/login', (req, res) =>
        LoginAPI.login(req, res))
    
    router.get('/forgot', authenticateToken, checkPrivileges(Privilege.USER), (req, res) =>
        api.version(req, res))

    router.get('/user', authenticateToken, checkPrivileges(Privilege.USER), (req, res) =>
        api.version(req, res))

    router.get('/version', authenticateToken, checkPrivileges(Privilege.USER), (req, res) =>
        VersionAPI.version(req, res))


}