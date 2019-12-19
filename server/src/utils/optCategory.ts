import { Category } from '../Category/category.entity';
export const toCateList = (data: Category[], p_id = 0) => {
    return data.reduce((total, curr) => {
        if (curr.p_id === p_id) {
            const newItem = {
                ...curr,
                list: toCateList(data.filter(item => item.type > curr.type), curr.id)
            }
            return [...total, newItem]
        } else {
            return [...total]
        }
    }, [])
}