import { Router } from 'express'
import { authenticateToken, checkPrivileges } from '../../middleware/authMiddleware'
import { Privilege } from '../../models/userModel'
import AdminAPI from '../../api/admin'
import ForgotAPI from '../../api/forgot'
import VersionAPI from '../../api/version'
import LoginAPI from '../../api/login'
import AccountAPI from '../../api/account'

const router = Router()

export function setAuthRoutes(app: any) {
    app.use('/api/v1', router)
    
    // Login allows you to send login request. No permissions required
    router.post('/login', (req, res) =>
        LoginAPI.login(req, res))
    
    // Login allows you to send forgot request. No permissions required
    router.get('/forgot', (req, res) =>
        ForgotAPI.forgotPassword(req, res))

    // Version allows you to send a simple version request. Need to be logged in with any permissions
    router.get('/version', authenticateToken, checkPrivileges(Privilege.GUEST), (req, res) =>
        VersionAPI.version(req, res))

    // User allows you to request user balance. Need to be logged in with user permissions or higher
    router.get('/balance', authenticateToken, checkPrivileges(Privilege.USER), (req, res) =>
        AccountAPI.balance(req, res))

    // Admin allows you to request admin info. Need to be logged in with admin permissions
    router.get('/admin', authenticateToken, checkPrivileges(Privilege.ADMIN), (req, res) =>
        AdminAPI.validate(req, res))
}