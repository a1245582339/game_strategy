import http from './config'
const domain = '/category'
export const getCategoryApi = <T>(): Promise<T> => {
    return http.get(`${domain}/all`)
}
export const addCategoryApi = (body: {p_id: number, name: string}) => {
    return http.post(domain, body)
}

export const editCategoryApi = (id: number, body: {name: string}) => {
    return http.put(`${domain}/${id}`, body)
}

export const delCategoryApi = (id: number) => {
    return http.delete(`${domain}/${id}`)
}