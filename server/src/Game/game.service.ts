import { Injectable } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { Repository, Like } from 'typeorm'
import { Game } from './game.entity'
import { GameDto } from './game.dto'
import { ArticleService } from '../Article/article.service'

@Injectable()
export class GameService {
    constructor(
        @InjectRepository(Game)
        private readonly gameService: Repository<Game>,
        private readonly articleService: ArticleService
    ){}
    async getByname(name: string = '', page: number = 0, size: number = 10, categoryId?: number): Promise<[Game[], number]> {
        const total = await this.gameService.count({
            name: Like(`%${name}%`), 
            del: 0
        })
        const gameList = await this.gameService.find({
            select: ['id', 'name', 'desp', 'cover', 'category'],
            relations: ['category'],
            where: {
                name: Like(`%${name}%`), 
                ... (categoryId ? { categoryId } : {}) ,
                del: 0
            },
            skip: page * size, 
            take: size 
        })
        return [gameList, total]
    }
    
    async create(body: GameDto): Promise<Game> {
        const create = await this.gameService.save(body)
        return create
    }
    async update(id: number, body: GameDto): Promise<boolean> {
        const update = await this.gameService.update({ id, del: 0 }, body)
        return !!update
    }
    async del(id: number): Promise<boolean> {
        const update = await this.gameService.update({ id, del: 0 }, { del: 1 })
        return !!update
    }
    async delGameByCategoryId(categoryId: number) {
        const gameIds = (await this.gameService.find({
            select: ['id'],
            where: {
                categoryId,
                del: 0
            }
        })).map(item => item.id)
        const delGame = this.gameService.update({ categoryId, del: 0 }, { del: 1 })
        const delArticle = (gameId: number) => this.articleService.delByGameId(gameId)
        const delResult = await Promise.all([delGame, ...gameIds.map(gameId => delArticle(gameId))])
        return delResult[0]
    }
}