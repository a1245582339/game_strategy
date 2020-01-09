import http from './config'
const domain = '/article'

export const getArticleListApi = <T>(params: { title?: string, page: number, size: number, gameId?: number }): Promise<T> => {
    return http.get(domain, { params })
}
export const getArticleDetailApi = <T>(id: number): Promise<T> => {
    return http.get(`${domain}/${id}`)
}
export const createArticleApi = <T>(body: T) => {
    return http.post(domain, body)
}
export const delArticleApi = (id: number) => {
    return http.delete(`${domain}/${id}`)
}