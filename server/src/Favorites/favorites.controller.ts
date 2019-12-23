import { Controller, Get, Param, Res, Post, Body, Put, Req, Delete, Query } from '@nestjs/common'
import { Response, Request } from 'express';
import { decode } from 'jsonwebtoken'
import { ParseIntPipe } from '@nestjs/common/pipes/parse-int.pipe';
import { FavortiesService } from './favorites.service';

@Controller('api/v1/favorties')
export class FavortiesController {
    constructor(private readonly favortiesServies: FavortiesService) {}
    @Get()
    async get(@Res() res: Response, @Req() req: Request, @Query() query: any) {
        const { page, size } = query
        try {
            const token = req.headers.authorization.split(' ')[1]
            const { id }: any = decode(token)
            const favortiesList = await this.favortiesServies.get(id, page, size)
            res.json({
                msg: 'Favorties list',
                list: favortiesList
            })
        } catch (error) {
            throw error
        }
    }
    @Post()
    async create(@Res() res: Response, @Req() req: Request, @Body('articleId', new ParseIntPipe()) articleId: number) {
        const token = req.headers.authorization.split(' ')[1]
        const { id }: any = decode(token)
        try {
            await this.favortiesServies.create(id, articleId)
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
            await this.favortiesServies.delById(id)
            res.json({
                msg: 'ok'
            })
        } catch (error) {
            throw error
        }
    }
    @Delete('cancel/:articleId')
    async del(@Param('articleId', new ParseIntPipe()) articleId:number, @Res() res: Response, @Req() req: Request) {
        const token = req.headers.authorization.split(' ')[1]
        const { userId }: any = decode(token)
        try {
            await this.favortiesServies.cancel(userId, articleId)
            res.json({
                msg: 'ok'
            })
        } catch (error) {
            throw error
        }
    }
}