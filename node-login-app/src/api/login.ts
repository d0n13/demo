import jwt from 'jsonwebtoken'
import { UserList, User } from "../models/userModel"
import { JWT_SECRET_KEY } from "../key/key"
import { HTTP } from "../protocol/httpCodes"

interface LoginRequest {
    username: string
    password: string
}

interface LoginResponse {
    name: string
    token: string
}

interface LoginFailResponse {
    message: string
}

class LoginAPI {

    private users: User[]

    constructor(users: User[]) {
        this.users = users
    }

    login(req: any, res: any): any {
        const { username, password }:LoginRequest = req.body

        const user = this.users.find(user => user.username === username && user.password === password)

        if (user) {
            
            const token = jwt.sign({ username: user.username, privileges: user.privilege }, JWT_SECRET_KEY, { expiresIn: '5m' })
            const response: LoginResponse = {
                name: user.name,
                token: token 
            }

            return res.status(HTTP.OK).json(response)
            
        } else {

            const response: LoginFailResponse = {message: 'Invalid username or password'}
            return res.status(HTTP.UNAUTHORIZED).json(response)
        }
    }
}

export default new LoginAPI(UserList)