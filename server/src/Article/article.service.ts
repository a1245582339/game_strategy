import { Injectable } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { Repository, Like } from 'typeorm'
import { Article } from './article.entity'
import { ArticleDto } from './article.dto'

@Injectable()
export class ArticleService {
    constructor(
        @InjectRepository(Article)
        private readonly articleService: Repository<Article>
    ){}
    getDetail(id: number): Promise<Article> {
        return this.articleService.findOne({
            relations: ['game'],
            where: {
                id, del: 0
            }
        })
    }
    async getList(title: string, page: number, size: number, gameId?: number): Promise<[Article[], number]> {
        const list = this.articleService.find({
            select: ['id', 'cover', 'title', 'gameId', 'create_time'],
            relations: ['game'],
            where: {
                title: Like(`%${title}%`),
                ...(gameId ? { gameId } : {}) ,
                del: 0
            },
            skip: page * size, 
            take: size,
            order: {
                create_time: 'DESC'
            }
        })
        const total = this.articleService.count({
            title: Like(`%${title}%`),
            ...(gameId ? { gameId } : {}) ,
            del: 0
        })
        return Promise.all([list, total])
    }
    create(body: ArticleDto): Promise<Article> {
        const create_time = Date.now().toString()
        return this.articleService.save({ ...body, create_time })
    }
    async delById(id: number) {
        try {
            const del = await this.articleService.update({ id, del: 0 }, { del: 1 })
            return del
        } catch (err) {
            throw err
        }
    }
    async delByGameId(gameId: number) {
        try {
            const del = await this.articleService.update({ gameId, del: 0 }, { del: 1 })
            return del
        } catch (err) {
            throw err
        }
    }
}