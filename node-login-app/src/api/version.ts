import { HTTP } from "../protocol/httpCodes"

class VersionAPI {

    version(req: any, res: any): any {

        return res.status(HTTP.OK).json({ version: '1.0.0'})
    }
}

export default new VersionAPI()