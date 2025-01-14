import { mockUsers, User } from "../models/userModel"
import { HTTP } from "../protocol/httpCodes"

interface ForgotPasswordRequest {
    username: string
}

interface ForgotPasswordResponse {
    success: boolean
    message: string
}
interface ForgotPasswordFailResponse {
    success: boolean
    message: string
}

class API {

    version(req: any, res: any): any {

        return res.status(HTTP.OK).json({ verison: '1.0.0'})
    }

    forgotPassword(req: any, res: any): any {

        const { username }: ForgotPasswordRequest = req.body
        
        const user = mockUsers.find(user => username === username)
        if (user) {

            let response: ForgotPasswordResponse = { success: true, message: 'Password reset email sent' }    
            return res.status(HTTP.OK).json(response)
        }
        
        let response: ForgotPasswordFailResponse = { success: false, message: 'User not found' }    
        return res.status(HTTP.UNAUTHORIZED).json(response)
    }

    updatePassword(req: any, res: any): any {

        const { username }: ForgotPasswordRequest = req.body
        
        const user = mockUsers.find(user => username === username)
        if (user) {

            let response: ForgotPasswordResponse = { success: true, message: 'Password reset email sent' }    
            return res.status(HTTP.OK).json(response)
        }
        
        let response: ForgotPasswordResponse = { success: false, message: 'User not found' }    
        return res.status(HTTP.UNAUTHORIZED).json(response)
    }
}

export default new API()