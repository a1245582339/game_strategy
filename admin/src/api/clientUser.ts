import http from './config'
const domain = '/client'
export const getClientUserApi = <T>(params: { login_name: string, page: number, size: number }): Promise<T> => {
    return http.get(`${domain}/user`, { params })
}
export const delClientUserApi = (id: number) => {
    return http.put(`${domain}/user/${id}`,  { del: 1 } )
}