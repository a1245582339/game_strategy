import http from './config'
const domain = '/admin'
export const loginApi = <T, U>(body: { name: string, password: string }): Promise<T & U> => {
    return http.post(`/auth${domain}/login`, body)
}
export const getUserInfoApi = <T>() :Promise<T> => {
    return http.get(`${domain}/me`)
}
export const getUserList = <T>(name: string) :Promise<T> => {
    return http.get(`${domain}`, { params: { ...( name ? { name } : {}), role: 2 } })
}
export const updateAdminApi = (id: number, body: { password?: string; del?: number }) => {
    return http.put(`${domain}/${id}`, body)
}
export const createAdminApi = <T>(body: { name: string; password: string }): Promise<T> => {
    return http.post(`${domain}`, { ...body, role: 2 })
}

export const changePasswordApi = <T>(body: {password: string; old_password: string}) :Promise<T> => {
    return http.put(`${domain}/changePassword`, body)
}