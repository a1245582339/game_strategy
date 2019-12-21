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
    getArticle(): Promise<Article[]> {
        return this.articleService.find({
        })
    }
    async delArticleByGameId(gameId: number) {
        try {
            const del = await this.articleService.update({ gameId, del: 0 }, { del: 1 })
            return del
        } catch (err) {
            throw err
        }
    }
}