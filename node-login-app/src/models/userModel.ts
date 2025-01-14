interface User {
    name: string
    username: string
    password: string
    privileges: Privilege[]
}

export enum Privilege {
    ADMIN = 'admin',
    USER = 'user',
    GUEST = 'guest'
}

export const PrivilegeHierarchy = {
    [Privilege.GUEST]: 0,
    [Privilege.USER]: 1,
    [Privilege.ADMIN]: 200
}

const mockUsers: User[] = [
    {
        name: "Donie Kelly",
        username: 'donie.kelly@gmail.com', password: 'donie123',
        privileges: [Privilege.ADMIN]
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
]

export { mockUsers, User }