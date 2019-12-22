import { Controller, Get, Param, Res, Post, Body, Put, Query, UseGuards } from '@nestjs/common'
import { Response } from 'express';
import { ParseIntPipe } from '@nestjs/common/pipes/parse-int.pipe';
import { ArticleDto } from './article.dto'
import { ArticleService } from './article.service'

@Controller('api/v1/article')
export class ArticleController {
    constructor(private readonly articleService: ArticleService) {}

    @Get()
    async getList(@Query() query: any, @Res() res: Response) {
        const { title, page, size } = query
        const list = (await this.articleService.getList(title || '', page || 0, size || 10))
                        .map(item => ({ ...item, game: item.game.name }))
        res.json({
            msg: 'Article list',
            list
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
    @Post()
    async create(@Res() res: Response, @Body() body: ArticleDto) {
        try {
            await this.articleService.create(body)
            res.json({
                msg: 'ok'
            })
        } catch (error) {
            throw error
        }
    }
    @Put('/del/:id')
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