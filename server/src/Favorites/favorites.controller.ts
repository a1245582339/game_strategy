import { Controller, Get, Param, Res, Post, Body, Put, Req, Delete, Query } from '@nestjs/common'
import { Response, Request } from 'express';
import { decode } from 'jsonwebtoken'
import { ParseIntPipe } from '@nestjs/common/pipes/parse-int.pipe';
import { FavortiesService } from './favorites.service';
import getIp from '../utils/getIp'

@Controller('api/v1/favorites')
export class FavortiesController {
    constructor(private readonly favortiesServies: FavortiesService) {}
    @Get()
    async get(@Res() res: Response, @Req() req: Request, @Query() query: any) {
        const { page, size } = query
        try {
            const token = req.headers.authorization.split(' ')[1]
            const { id }: any = decode(token)
            const favortiesList = (await this.favortiesServies.get(id, page, size)).map(item => {
                return { ...item, article: { ...item.article, cover: `http://${getIp()}${item.article.cover}` } }
            })
            res.json({
                msg: 'Favorties list',
                list: favortiesList
            })
        } catch (error) {
            throw error
        }
    }

    @Get('ifFavorite')
    async getIfFavorite(@Res() res: Response, @Req() req: Request, @Query() query: any) {
        const { articleId } = query
        try {
            const token = req.headers.authorization.split(' ')[1]
            const { id }: any = decode(token)
            const ifFavorite = await this.favortiesServies.getIfFavorite(id, articleId)
            res.json({
                msg: 'If Favorite',
                ifFavorite
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
    @Put('delByid')
    async delById(@Body('ids') ids:string, @Res() res: Response) {
        try {
            await Promise.all(JSON.parse(ids).map(id => this.favortiesServies.delById(id)))
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
        const { id }: any = decode(token)
        try {
            await this.favortiesServies.cancel(id, articleId)
            res.json({
                msg: 'ok'
            })
        } catch (error) {
            throw error
        }
    }
}