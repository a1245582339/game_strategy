import http from './config'
interface ILoginParams {
    name: string
    password: string
}
export const login = <T>(body: ILoginParams): Promise<T> => {
    return http.post('/api/v1/auth/admin/login', body)
}