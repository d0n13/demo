"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class API {
    version(req, res) {
        return res.status(200).json({ verison: '1.0.0' });
    }
}
exports.default = new API();
