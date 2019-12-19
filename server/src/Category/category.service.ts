import { Injectable } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { Repository, LessThan, Like } from 'typeorm'
import { Category } from './category.entity'
import { CategoryDto } from './category.dto'

@Injectable()
export class CategoryService {
    constructor(
        @InjectRepository(Category)
        private readonly categoryService: Repository<Category>
    ){}
    getCateory(): Promise<Category[]> {
        // 获取所有分类
        return this.categoryService.find({
            select: ['id', 'name', 'type', 'p_id'],
            where: {
                type: LessThan(3)
            }
        })
    }
    getGame(name: string, page: number, size: number): Promise<CategoryDto[]> {
        return this.categoryService.find({
            select: ['id', 'name'],
            where: {
                name: Like(`%${name}%`),
                is_del: 0
            }, 
            skip: page * size,
            take: size
        })
    }
    async create(body: CategoryDto): Promise<boolean> {
        const { p_id } = body
        const parent = await this.categoryService.findOne({ id: p_id , is_del: 0 })
        if (!parent) {
            throw new Error('No found parent by p_id')
        }
        const type = parent.type + 1
        const l_id = parent.r_id
        const r_id = l_id + 1
        try {
            const updateRid = this.categoryService.createQueryBuilder().update(Category).set({
                r_id: () => "r_id + 2",
            }).where(
                'r_id>=:r_id and is_del=0', {r_id: r_id - 1}
            ).execute()
            const updateLid = this.categoryService.createQueryBuilder().update(Category).set({
                l_id: () => "l_id + 2",
            }).where(
                'l_id>=:l_id and is_del=0', {l_id}
            ).execute()
            await Promise.all([updateRid, updateLid])
            const create = await this.categoryService.save({...body, type, l_id, r_id})
            return !!create
        } catch (err) {
            throw err
        }
    }
    async update(id: number, name: string): Promise<boolean> {
        try {
            const update = await this.categoryService.update({
                id, is_del: 0
            }, { name })
            return !!update.raw.changedRows
        } catch (err) {
            throw err
        }
    }
    async delete(id: number) {
        try {
            const catecory = await this.categoryService.findOne({ id , is_del: 0 })
            if (!catecory.p_id) return false
            if (!catecory) return false
            const { l_id, r_id } = catecory
            await this.categoryService.createQueryBuilder().delete().from(Category).where(
                'l_id>=:l_id and r_id<=:r_id and is_del=0', { l_id, r_id }
            ).execute()
            const updateRid = this.categoryService.createQueryBuilder().update(Category).set({
                r_id: () => `r_id-(${r_id-l_id+1})`
            }).where(
                'r_id>=:r_id and is_del=0', { r_id }
            ).execute()
            const updateLid = this.categoryService.createQueryBuilder().update(Category).set({
                l_id: () => `l_id-(${r_id-l_id+1})`
            }).where(
                'l_id>=:l_id and is_del=0', { l_id }
            ).execute()
            await Promise.all([updateRid, updateLid])
            return true
        } catch (err) {
            throw err
        }
    }
}