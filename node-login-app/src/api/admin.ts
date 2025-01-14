import { UserList, User, Privilege } from "../models/userModel"
import { HTTP } from "../protocol/httpCodes"

interface ValidateResponse{
    name: string
    message: string
    privilege: Privilege
}

interface ValidateFailResponse {
    success: boolean
    message: string
}

class AdminAPI {

    validate(req: any, res: any): any {

        const user = UserList.find(user => user.username === req.user.username && user.privilege == Privilege.ADMIN) as User
        if (user) {

            let response: ValidateResponse = {
                name: user.name,
                message: 'User checked is an admin',
                privilege: user.privilege
            }    
            return res.status(HTTP.OK).json(response)
        }
        
        let response: ValidateFailResponse = {
            success: false,
            message: 'User not found'
        }    
        return res.status(HTTP.METHOD_NOT_ALLOWED).json(response)
    }
}

export default new AdminAPI()