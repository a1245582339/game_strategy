import { Controller, Get, Param, Res, Req, Body, Put, Query, HttpStatus } from '@nestjs/common'
import { Response, Request } from 'express';
import { decode } from 'jsonwebtoken'
import { ParseIntPipe } from '@nestjs/common/pipes/parse-int.pipe';
import { CommentService } from './comment.service';

@Controller('api/v1/comment')
export class CommentController {
    constructor(private readonly commentService: CommentService) {}
    @Get()
    async getComments(@Query('articleId') articleId: number, @Res() res: Response) {
        let comment: any, total: number
        [comment, total] = await this.commentService.getComments(articleId)
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
    @Put('del/:id')
    async del(@Param('id', new ParseIntPipe()) id:number, @Res() res: Response, @Req() req: Request) {
        try {
            const token = req.headers.authorization.split(' ')[1]
            const { userId }: any = decode(token)
            const del = await this.commentService.del(id, userId)
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