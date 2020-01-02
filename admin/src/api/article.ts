import http from './config'
const domain = '/article'

export const getArticleList = <T>(params: { name?: string, page: number, size: number, categoryId?: number }): Promise<T> => {
    return http.get(domain, { params })
}