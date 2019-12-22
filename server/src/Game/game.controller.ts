import { Controller, Get, Param, Res, Post, Body, Put, Query } from '@nestjs/common'
import { Response } from 'express';
import { ParseIntPipe } from '@nestjs/common/pipes/parse-int.pipe';
import { GameService } from './game.service'
import { GameDto } from './game.dto'

@Controller('api/v1/game')
export class GameController {
    constructor(private readonly gameService: GameService) {}
    @Get()
    async getGame(@Query() query: any, @Res() res: Response) {
        const { name, page, size } = query
        try {
            const gameList = await this.gameService.getByname(name, page, size)
            res.json({
                msg: 'Game list',
                list: gameList
            })
        } catch (err) {
            throw err
        }
    }

    @Get('/detail/:id')
    async getGameDetail(@Param('id', new ParseIntPipe()) id:number, @Res() res: Response) {
        try {
            const detail = await this.gameService.getDetail(id)
            res.json({
                detail,
                msg: 'detail'
            })
        } catch (err) {
            throw err
        }
    }

    @Post()
    async create(@Body() body: GameDto, @Res() res: Response) {
        try {
            await this.gameService.create(body)
            res.json({
                msg: 'Ok'
            })
        } catch (error) {
            throw error
        }
    }

    @Put('/update/:id')
    async update(@Param('id', new ParseIntPipe()) id:number, @Body() body: GameDto, @Res() res: Response) {
        try {
            await this.gameService.update(id, body)
        } catch (error) {
            throw error
        }
    }

    @Put('/del/:id')
    async delGame(@Param('id', new ParseIntPipe()) id:number, @Res() res: Response) {
        // const del = await this.gameService.delGame(id)
        res.json({msg: 'Ok'})
    }
}