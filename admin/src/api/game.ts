import http from './config'
const domain = '/game'

interface IGame {
    name: string
    desp: string
    cover: string
    categoryId: number
}
export const getGameApi = <T>(params: { name?: string, page: number, size: number, categoryId?: number }): Promise<T> => {
    return http.get(domain, { params })
}
export const addGameApi = (body: IGame) => {
    return http.post(domain, body)
}
export const editGameApi = (id: number, body: IGame) => {
    return http.put(`${domain}/${id}`, body)
}
export const delGameApi = (id: number) => {
    return http.delete(`${domain}/${id}`)
}