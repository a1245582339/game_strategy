import { Controller, Get, Param, Res, Post, Body, Put, Query, UseGuards, Delete } from '@nestjs/common'
import { Response } from 'express';
import { ParseIntPipe } from '@nestjs/common/pipes/parse-int.pipe';
import { ArticleDto } from './article.dto'
import { ArticleService } from './article.service'
import { AuthGuard } from '@nestjs/passport'

@Controller('api/v1/article')
export class ArticleController {
    constructor(private readonly articleService: ArticleService) {}

    @Get()
    async getList(@Query() query: any, @Res() res: Response) {
        const { title, page, size, gameId } = query
        let list: any, total: number
        [list, total] = await this.articleService.getList(title || '', page || 0, size || 10, gameId)
        list = list.map((item: any) => ({ ...item, game: item.game.name }))
        res.json({
            msg: 'Article list',
            list,
            total
        })
    }
    @Get('detail/:id')
    async getDetail(@Param('id', new ParseIntPipe()) id:number, @Res() res: Response) {
        const detail = (await this.articleService.getDetail(id))
        res.json({
            msg: 'Article list',
            detail
        })
    }
    @UseGuards(AuthGuard('jwt'))
    @Post()
    async create(@Res() res: Response, @Body() body: ArticleDto) {
        try {
            const cover = body.cover || 'http://localhost:3000/public/defaultCover.png'
            await this.articleService.create({ ...body, cover})
            res.json({
                msg: 'ok'
            })
        } catch (error) {
            throw error
        }
    }
    @UseGuards(AuthGuard('jwt'))
    @Delete('/:id')
    async del(@Param('id', new ParseIntPipe()) id:number, @Res() res: Response) {
        try {
            await this.articleService.delById(id)
            res.json({
                msg: 'ok'
            })
        } catch (err) {
            throw err
        }
    }
}