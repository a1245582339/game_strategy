import { Injectable } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { Repository, getConnection } from 'typeorm'
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
    async getGameDetail(id: number) {
        const detail = await this.gameService.find({
            relations: ['category'],
            where: {
                id, del: 0
            }
        })
        return detail
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
        const delArticle = (gameId: number) => this.articleService.delArticleByGameId(gameId)
        const delResult = await Promise.all([delGame, ...gameIds.map(gameId => delArticle(gameId))])
        return delResult[0]
    }
}