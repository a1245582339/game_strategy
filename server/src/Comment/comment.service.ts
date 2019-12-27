import { Injectable } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { Repository, LessThan, LessThanOrEqual } from 'typeorm'
import { Comment } from './comment.entity'
import { CommentDto } from './comment.dto'
import { ClientUserService } from '../ClientUser/client.service'

@Injectable()
export class CommentService {
    constructor(
        @InjectRepository(Comment)
        private readonly commentService: Repository<Comment>,
        private readonly clientUserService: ClientUserService
    ) {}
    async getComments (articleId: number, page: number = 0, size: number = 0): Promise<[any[], number]> {
        // 获取文章评论
        const getCommentsDetail = async () => {
            const comments: any = await this.commentService.find({
                relations: ['user'],
                where: {
                    articleId, del: 0
                },
                skip: page * size, 
                take: size
            })
            const getReplyUser = (userId: number) => {
                return this.clientUserService.getOne(userId)
            }
            return (await Promise.all(comments.map((item: Comment) => {
                return getReplyUser(item.replyUserId)
            }))).map((_item: any, index) => {
                comments[index].replyUser = _item || 0
                return comments[index]
            })
        }
        const total = this.commentService.count({
            articleId, del: 0
        })
        return Promise.all([getCommentsDetail(), total])
    }
    async getMyReplied (userId: number, page: number = 0, size: number = 0): Promise<[Comment[], number]> {
        const comment = this.commentService.find({
            select: ['article', "user", 'content', 'create_time', 'read'],
            relations: ['article', 'user'],
            where: {
                del: 0,
                replyUserId: userId
            },
            skip: page * size, 
            take: size,
            order: {
                create_time: 'DESC'
            }
        })
        const total = this.commentService.count({
            replyUserId: userId, del: 0
        })
        return Promise.all([comment, total])
    }
    getUnreadCount (replyUserId: number): Promise<number> {
        return this.commentService.count({
            del: 0, read: 0, replyUserId
        })
    }
    async read(time: string) {
        return this.commentService.update({
            del: 0, create_time: LessThanOrEqual(time)
        }, { read: 1 })
    }
    async create (body: CommentDto): Promise<Comment> {
        return this.commentService.save({ ...body, create_time: Date.now().toString() })
    }
    async del (id: number, userId: number): Promise<boolean> {
        const del = await this.commentService.update({ id, userId, del: 0 }, { del: 1 })
        return !!del
    }
}