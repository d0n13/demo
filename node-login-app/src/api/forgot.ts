import { UserList, User } from "../models/userModel"
import { HTTP } from "../protocol/httpCodes"

interface ForgotPasswordRequest {
    username: string
}

interface ForgotPasswordResponse {
    message: string
}

interface ForgotPasswordFailResponse {
    message: string
}

class ForgotAPI {

    forgotPassword(req: any, res: any): any {

        const { username }: ForgotPasswordRequest = req.body
        
        const user = UserList.find(user => username === username)
        if (user) {

            let response: ForgotPasswordResponse = {
                message: 'Password reset email sent'
            }    
            console.log(response)
            return res.status(HTTP.OK).json(response)
        }
        
        let response: ForgotPasswordFailResponse = {message: 'User not found'}    
        return res.status(HTTP.UNAUTHORIZED).json(response)
    }
}

export default new ForgotAPI()