export interface IUserInfo {
    id: number
    name: string
    role: number
}
export interface ISetUserInfo {
    value: IUserInfo,
    type: string
}

export interface IDelUserInfo {
    type: string
}

export type UserAction = ISetUserInfo & IDelUserInfo

export const setUserInfo = (value: IUserInfo): ISetUserInfo => ({
    type: 'SET_USR_INFO',
    value
})
export const delUserInfo = () => ({
    type: 'DEL_USER_INFO'
})