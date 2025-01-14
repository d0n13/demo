interface User {
    name: string
    username: string
    password: string
    privilege: Privilege,
    balance: number
}

export enum Privilege {
    ADMIN = 'admin',
    USER = 'user',
    GUEST = 'guest',
    UNKNOWN = 'unknown'
}

export const PrivilegeHierarchy = {
    [Privilege.UNKNOWN]: -1,
    [Privilege.GUEST]: 0,
    [Privilege.USER]: 1,
    [Privilege.ADMIN]: 200
}

const UserList: User[] = [
    {
        name: "Donie Kelly",
        username: 'donie@gmail.com', password: 'donie',
        privilege: Privilege.ADMIN,
        balance: 98330
    },
    {
        name: "Jason Barry",
        username: 'jason@gmail.com', password: 'jason',
        privilege: Privilege.USER,
        balance: 1000

    },
    {
        name: "Guest User",
        username: 'guest@gmail.com', password: 'guest',
        privilege: Privilege.GUEST,
        balance: 0
    },
]

export { UserList, User }