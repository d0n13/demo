"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const userModel_1 = require("../models/userModel");
const key_1 = require("../key/key");
class AuthController {
    constructor(users) {
        this.users = users;
    }
    login(req, res) {
        const { username, password } = req.body;
        const user = this.users.find(user => user.username === username && user.password === password);
        if (user) {
            const token = jsonwebtoken_1.default.sign({ username: user.username, privileges: user.privileges }, key_1.JWT_SECRET_KEY, { expiresIn: '5m' });
            return res.status(200).json({ success: true, name: user.name, token: token });
        }
        else {
            return res.status(401).json({ success: false, message: 'Invalid username or password' });
        }
    }
}
exports.default = new AuthController(userModel_1.mockUsers);
