import { Injectable } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { Repository } from 'typeorm'
import { Comment } from './comment.entity'

@Injectable()
export class CommentService {
    constructor(
        @InjectRepository(Comment)
        private readonly commentService: Repository<Comment>
    ) {}
    async getComments (articleId: number, page: number = 0, size: number = 0): Promise<[Comment[], number]> {
        // 获取文章评论
        const comments = this.commentService.find({
            relations: ['user'],
            where: {
                articleId, del: 0
            },
            skip: page * size, 
            take: size 
        })
        const total = this.commentService.count({
            articleId, del: 0
        })
        return Promise.all([comments, total])
    }
    async del (id: number, userId: number): Promise<boolean> {
        const del = await this.commentService.update({ id, userId, del: 0 }, { del: 1 })
        return !!del
    }
}