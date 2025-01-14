"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.setAuthRoutes = void 0;
const express_1 = require("express");
const authMiddleware_1 = require("../../middleware/authMiddleware");
const userModel_1 = require("../../models/userModel");
const authController_1 = __importDefault(require("../../controllers/authController"));
const api_1 = __importDefault(require("../../controllers/api"));
const router = (0, express_1.Router)();
function setAuthRoutes(app) {
    app.use('/api/v1', router);
    router.post('/login', (req, res) => authController_1.default.login(req, res));
    router.get('/version', authMiddleware_1.authenticateToken, (0, authMiddleware_1.checkPrivileges)([userModel_1.Privilege.ADMIN]), (req, res) => api_1.default.version(req, res));
}
exports.setAuthRoutes = setAuthRoutes;
