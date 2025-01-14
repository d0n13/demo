import { Request, Response, NextFunction } from 'express'
import jwt from 'jsonwebtoken'
import { JWT_SECRET_KEY } from "../key/key"
import { Privilege , PrivilegeHierarchy} from "../models/userModel"
import { HTTP } from "../protocol/httpCodes"

declare module 'express-serve-static-core' {
    interface Request {
        user?: {
            privileges: Privilege,
            username: string
        }
    }
}

export function authenticateToken(req: Request, res: Response, next: NextFunction) {

    verifyToken(req).then(() => {

        next()

    }).catch((error) => {

        res.sendStatus(error)
    })
}

export function checkPrivileges(required: Privilege) {

    return (req: Request, res: Response, next: NextFunction) => {
        
        verifyToken(req).then(() => {

            if(PrivilegeHierarchy[req.user?.privileges || Privilege.UNKNOWN] < PrivilegeHierarchy[required]) {
            
                return res.status(HTTP.FORBIBBEN).json({ message: 'Insufficient privileges' })
            }

            next()

        }).catch((error) => {

            res.sendStatus(error)
        })
    }
}

function verifyToken(req: Request): Promise<void> {

    return new Promise((resolve, reject) => {
        
        const authHeader = req.headers['authorization']
        const token = authHeader && authHeader.split(' ')[1]

        if (token == null) {
            reject(HTTP.UNAUTHORIZED)
            return
        }

        jwt.verify(token, JWT_SECRET_KEY, (err: any, user: any) => {
            
            if (err) {
                reject(HTTP.FORBIBBEN)
            } else {
                req.user = user
                resolve()
            }
        })
    })
}