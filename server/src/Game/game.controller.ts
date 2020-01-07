import { Controller, Get, Param, Res, Post, Body, Put, Query, UseGuards, Delete } from '@nestjs/common'
import { Response } from 'express';
import { ParseIntPipe } from '@nestjs/common/pipes/parse-int.pipe';
import { GameService } from './game.service'
import { GameDto } from './game.dto'
import { AuthGuard } from '@nestjs/passport'
import getIp from '../utils/getIp'

@Controller('api/v1/game')
export class GameController {
    constructor(private readonly gameService: GameService) {}
    @Get()
    async getGame(@Query() query: any, @Res() res: Response) {
        const { name, page, size, categoryId } = query
        try {
            const [gameList, total] = await this.gameService.getByname(name, page, size, categoryId)
            res.json({
                msg: 'Game list',
                list: gameList.map(item => ({ ...item, cover: `http://${getIp()}${item.cover}`})),
                total
            })
        } catch (err) {
            throw err
        }
    }
    
    @UseGuards(AuthGuard('jwt'))
    @Post()
    async create(@Body() body: GameDto, @Res() res: Response) {
        try {
            const cover = body.cover || '/public/defaultCover.png'
            await this.gameService.create({ ...body, cover })
            res.json({
                msg: 'Ok'
            })
        } catch (error) {
            throw error
        }
    }
    @UseGuards(AuthGuard('jwt'))
    @Put('/:id')
    async update(@Param('id', new ParseIntPipe()) id:number, @Body() body: GameDto, @Res() res: Response) {
        try {
            await this.gameService.update(id, body)
            res.json({
                msg: 'Ok'
            })
        } catch (error) {
            throw error
        }
    }
    @UseGuards(AuthGuard('jwt'))
    @Delete('/:id')
    async delGame(@Param('id', new ParseIntPipe()) id:number, @Res() res: Response) {
        await this.gameService.del(id)
        res.json({msg: 'Ok'})
    }
}