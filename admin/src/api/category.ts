import http from './config'
const domain = '/category'
export const getCategoryApi = <T>(): Promise<T> => {
    return http.get(`${domain}/all`)
}