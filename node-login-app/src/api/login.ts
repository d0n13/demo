import jwt from 'jsonwebtoken'
import { mockUsers, User } from "../models/userModel"
import { JWT_SECRET_KEY } from "../key/key"
import { HTTP } from "../protocol/httpCodes"

interface LoginResponse {
    success: boolean
    name: string
    token: string
}

interface LoginFailResponse {
    success: boolean
    message: string
}

class LoginAPI {
    private users: User[]

    constructor(users: User[]) {
        this.users = users
    }

    login(req: any, res: any): any {
        const { username, password } = req.body

        const user = this.users.find(user => user.username === username && user.password === password)

        if (user) {
            
            const token = jwt.sign({ username: user.username, privileges: user.privileges }, JWT_SECRET_KEY, { expiresIn: '5m' })
            const response: LoginResponse = {
                success: true, name: user.name, token: token 
            }

            return res.status(HTTP.OK).json(response)
            
        } else {

            const response: LoginFailResponse = {
                success: false, message: 'Invalid username or password' 
            }
            return res.status(HTTP.UNAUTHORIZED).json(response)
        }
    }
}

export default new LoginAPI(mockUsers)