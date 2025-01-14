import { UserList, User, Privilege } from "../models/userModel"
import { HTTP } from "../protocol/httpCodes"

interface BalanceRequest {
    username: string
}

interface BalanceResponse {
    name: string
    balanceStatus: string,
    balance: number
}

interface BalanceFailResponse {
    message: string
}

class AccountAPI {

    balance(req: any, res: any): any {

        const { username }: BalanceRequest = req.body
        var balanceStatus: string
        
        // Get the username from the JWT token
        console.log(`User from request: ${req.user.username}`)
        const user = UserList.find(user => user.username === req.user.username) as User

        // const user = UserList.find(user => username === username) as User

        console.log(`user: ${user}. Looking for ${username}`);

        if (user) {

            if (user.balance > 50000) {
                balanceStatus = 'User balance is above 50000'
            } else {
                balanceStatus = 'User balance is low'
            }

            var response: BalanceResponse = {
                name: user.name,
                balanceStatus: balanceStatus,
                balance: user.balance || 0
            }

            return res.status(HTTP.OK).json(response)
        }
        
        let failResponse: BalanceFailResponse = {message: `User ${username} not found`}    
        return res.status(HTTP.METHOD_NOT_ALLOWED).json(failResponse)
    }
}

export default new AccountAPI()