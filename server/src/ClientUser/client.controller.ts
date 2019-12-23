import { Controller, Get, Param, Res, HttpStatus, Post, Body, Put, Query, UseGuards } from '@nestjs/common'
import { Response } from 'express';
import { ParseIntPipe } from '@nestjs/common/pipes/parse-int.pipe';
import { ClientDto } from './client.dto'
import { ClientUserService } from './client.service'
import { AuthGuard } from '@nestjs/passport'

@Controller('api/v1/client')
export class ClientUserController {
    constructor(
        private readonly clientUserService: ClientUserService
    ){}
    @UseGuards(AuthGuard('jwt'))
    @Get('user')
    async get(@Res() res: Response, @Query() query: ClientDto) {
        try {
            const page = query.page || 0
            const size = query.size || 10
            const _query = { ... query }
            delete _query.page
            delete _query.size
            const [userList, total] = await this.clientUserService.get(_query, page, size)
            res.json({
                msg: 'Client user list',
                list: userList,
                total
            })
        } catch (err) {
            throw err
        }
    }
    @UseGuards(AuthGuard('jwt'))
    @Get('check')
    async checkExsit(@Query('login_name') login_name:string, @Res() res: Response) {
        try {
            const result = await this.clientUserService.checkExist(login_name)
            res.json({
                msg: 'Exist status',
                data: {
                    exist: result
                }
            })
        } catch (err) {
            throw err
        }
    }

    @Post('user')
    async create(@Res() res: Response, @Body() body:ClientDto) {
        try {
            if (await this.clientUserService.create(body)) {
                res.status(HttpStatus.CREATED).json({
                    msg: 'Ok'
                })
            } else {
                res.status(HttpStatus.CONFLICT).json({
                    msg: 'Name exist'
                })
            }
        } catch (err) {
            throw err
        }
    }

    @UseGuards(AuthGuard('jwt'))
    @Put('user/:id')
    async update(@Param('id', new ParseIntPipe()) id:number, @Body() body:ClientDto, @Res() res: Response) {
        try {
            await this.clientUserService.update(id, body)
            res.json({
                msg: "Ok"
            })
        } catch (err) {
            throw err
        }
    }
}
