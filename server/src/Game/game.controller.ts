import { Controller, Get, Param, Res, HttpStatus, Post, Body, Put, Query, UseGuards } from '@nestjs/common'
import { Response } from 'express';
import { ParseIntPipe } from '@nestjs/common/pipes/parse-int.pipe';
import { GameService } from './game.service'
import { GameDto } from './game.dto'
import { Game } from './game.entity'

@Controller('api/v1/game')
export class GameController {
    constructor(private readonly gameService: GameService) {}
    @Get('/detail/:id')
    async getGameDetail(@Param('id', new ParseIntPipe()) id:number) {
        return await this.gameService.getGameDetail(id)
    }

    @Put('/del/:id')
    async delGame(@Param('id', new ParseIntPipe()) id:number, @Res() res: Response) {
        // const del = await this.gameService.delGame(id)
        res.json({msg: 'Ok'})
    }
}