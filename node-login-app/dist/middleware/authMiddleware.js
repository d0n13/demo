"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.checkPrivileges = exports.authenticateToken = void 0;
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const key_1 = require("../key/key");
function authenticateToken(req, res, next) {
    verifyToken(req).then(() => {
        next();
    }).catch((error) => {
        res.sendStatus(error);
    });
}
exports.authenticateToken = authenticateToken;
function checkPrivileges(requiredPrivileges) {
    return (req, res, next) => {
        verifyToken(req).then(() => {
            var _a;
            const userPrivileges = ((_a = req.user) === null || _a === void 0 ? void 0 : _a.privileges) || [];
            const hasPrivileges = requiredPrivileges.every(privilege => userPrivileges.includes(privilege));
            console.log(hasPrivileges);
            if (!hasPrivileges) {
                return res.status(403).json({ message: 'Insufficient privileges' });
            }
            next();
            // Check that our user has the required privileges
            // const userPrivileges: Privilege[] = req.privileges || [];
            // console.log(userPrivileges);
            // const hasPrivileges = requiredPrivileges.every(privilege => userPrivileges.includes(privilege));
            // console.log(hasPrivileges);
            // if (!hasPrivileges) {
            //     return res.status(403).json({ message: 'Insufficient privileges' });
            // }
            next();
        }).catch((error) => {
            res.sendStatus(error);
        });
    };
}
exports.checkPrivileges = checkPrivileges;
function verifyToken(req) {
    return new Promise((resolve, reject) => {
        const authHeader = req.headers['authorization'];
        const token = authHeader && authHeader.split(' ')[1];
        if (token == null) {
            reject(401);
            return;
        }
        jsonwebtoken_1.default.verify(token, key_1.JWT_SECRET_KEY, (err, user) => {
            if (err) {
                reject(403);
            }
            else {
                req.user = user;
                resolve();
            }
        });
    });
}
