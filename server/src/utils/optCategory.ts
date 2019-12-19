import { Category } from '../Category/category.entity';
const toCateList = (data: Category[], type = 0) => {
    const newData = data.reduce((total, curr) => {
        if (curr.type === type) {
            const newItem = {
                id: 0,
                list: [],
                name: ''
            }
            const fatherIndex = total.findIndex(item => item.id === curr.id)
            // fatherIndex > -1 ?  newItem.list[fatherIndex].push : new
        }
        return []
    }, [])
}