"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.mockUsers = exports.Privilege = void 0;
var Privilege;
(function (Privilege) {
    Privilege[Privilege["ADMIN"] = 1001] = "ADMIN";
    Privilege[Privilege["USER"] = 1002] = "USER";
    Privilege[Privilege["GUEST"] = 1003] = "GUEST";
})(Privilege = exports.Privilege || (exports.Privilege = {}));
const mockUsers = [
    {
        name: "Donie Kelly",
        username: 'donie.kelly@gmail.com', password: 'donie123',
        privileges: [Privilege.ADMIN, Privilege.USER, Privilege.GUEST]
    },
    {
        name: "Jason Barry",
        username: 'jaywbarry@gmail.com', password: 'jay123',
        privileges: [Privilege.ADMIN, Privilege.USER]
    },
    {
        name: "Guest User",
        username: 'guest@gmail.com', password: '1234',
        privileges: [Privilege.GUEST]
    },
];
exports.mockUsers = mockUsers;
