import { Injectable } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { Repository, Between, LessThan } from 'typeorm'
import { Category } from './category.entity'
import { CategoryDto } from './category.dto'

@Injectable()
export class CategoryService {
    constructor(
        @InjectRepository(Category)
        private readonly categoryService: Repository<Category>
    ){}
    getCateory(): Promise<CategoryDto[]> {
        // 获取所有分类
        return this.categoryService.find({
            type: LessThan(3)
        })
    }
    async create(body: CategoryDto) {
        const { p_id } = body
        const parent = await this.categoryService.findOne({ id: p_id , is_del: 0 })
        if (!parent) {
            throw new Error('No found parent by p_id')
        }
        const type = parent.type + 1
        const l_id = parent.r_id
        const r_id = l_id + 1
        try {
            const create = await this.categoryService.save({...body, type, l_id, r_id})
            return !!create
        } catch (err) {
            throw err
        }
    }
}