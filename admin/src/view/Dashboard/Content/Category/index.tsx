import React, { useEffect, useState } from 'react';
import { getCategoryApi } from '@/api/category'
interface ICategory {
    id: number
    p_id: number
    name: string
    type: number,
    list: ICategory[]
}
const Category: React.FC = () => {
    
    return (
        <>
            <div>Category</div>
        </>
    )
}
export default Category