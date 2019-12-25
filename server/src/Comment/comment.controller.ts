import { Controller, Get, Param, Res, Req, Body, Put, Query, HttpStatus, Post } from '@nestjs/common'
import { Response, Request } from 'express';
import { decode } from 'jsonwebtoken'
import { ParseIntPipe } from '@nestjs/common/pipes/parse-int.pipe';
import { CommentService } from './comment.service';
import { CommentDto } from './comment.dto'
import { CommentGateway } from './comment.gateway'

@Controller('api/v1/comment')
export class CommentController {
    constructor(
        private readonly commentService: CommentService,
        private readonly commentGateway: CommentGateway
    ) {}
    @Get()
    async getComments(@Query() query: any, @Res() res: Response) {
        let comment: any, total: number
        const { articleId, page, size } = query;
        [comment, total] = await this.commentService.getComments(articleId, page, size)
        comment = comment.map((item: any) => {
            const user = {
                id: item.user.id,
                name: item.user.nick_name || item.user.login_name,
                avatar: item.user.avatar,
            }
            return {
                ...item,
                user
            }
        })
        res.json({
            msg: 'Comment list',
            list: comment,
            total
        })
    }
    @Get('/myReplied')
    async getMyReplied(@Res() res: Response, @Query() query: any, @Req() req: Request) {
        const { page, size } = query;
        let comment: any, total: number
        const token = req.headers.authorization.split(' ')[1]
        const { id }: any = decode(token);
        [comment, total] = await this.commentService.getMyReplied(id, page, size)
        comment = comment.map((item: any) => {
            const user = {
                id: item.user.id,
                name: item.user.nick_name || item.user.login_name,
                avatar: item.user.avatar,
            }
            return {
                ...item,
                user
            }
        })
        res.json({
            msg: 'Comment list',
            list: comment,
            total
        })
    }
    @Post()
    async create(@Res() res: Response, @Body() body: CommentDto) {
        const result = await this.commentService.create(body)
        this.commentGateway.server.to('123').emit('event', result)
        console.log(result)
        res.json({
            msg: 'Ok'
        })
    }
    @Put('del/:id')
    async del(@Param('id', new ParseIntPipe()) id:number, @Res() res: Response, @Req() req: Request) {
        try {
            const token = req.headers.authorization.split(' ')[1]
            const userInfo: any = decode(token)
            const del = await this.commentService.del(id, userInfo.id)
            if (del) {
                res.json({
                    msg: 'Ok'
                })
            } else {
                res.status(HttpStatus.UNAUTHORIZED).json({
                    msg: 'Not owner'
                })
            }
        } catch (error) {
            throw error
        }
        
    }
}