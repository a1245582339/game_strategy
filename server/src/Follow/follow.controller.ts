import { Controller, Get, Param, Res, Post, Body, Put, Req, Delete, Query } from '@nestjs/common'
import { Response, Request } from 'express';
import { decode } from 'jsonwebtoken'
import { ParseIntPipe } from '@nestjs/common/pipes/parse-int.pipe';
import { FollowService } from './follow.service'

@Controller('api/v1/follow')
export class FollowController {
    constructor(private readonly followService: FollowService) {}
    @Get()
    async get(@Res() res: Response, @Req() req: Request, @Query() query: any) {
        const { page, size } = query
        try {
            const token = req.headers.authorization.split(' ')[1]
            const { id }: any = decode(token)
            const followList = await this.followService.get(id, page, size)
            res.json({
                msg: 'Follow list',
                list: followList
            })
        } catch (error) {
            throw error
        }
        
    }
    @Post()
    async create(@Res() res: Response, @Req() req: Request, @Body('gameId', new ParseIntPipe()) gameId: number) {
        const token = req.headers.authorization.split(' ')[1]
        const { id }: any = decode(token)
        try {
            await this.followService.create(id, gameId)
            res.json({
                msg: 'ok'
            })
        } catch (error) {
            throw error
        }
    }
    @Delete('delByid/:id')
    async delById(@Param('id', new ParseIntPipe()) id:number, @Res() res: Response) {
        try {
            await this.followService.delById(id)
            res.json({
                msg: 'ok'
            })
        } catch (error) {
            throw error
        }
    }
    @Delete('cancel/:gameId')
    async del(@Param('gameId', new ParseIntPipe()) gameId:number, @Res() res: Response, @Req() req: Request) {
        const token = req.headers.authorization.split(' ')[1]
        const { userId }: any = decode(token)
        try {
            await this.followService.cancel(userId, gameId)
            res.json({
                msg: 'ok'
            })
        } catch (error) {
            throw error
        }
    }
}