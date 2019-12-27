import { Controller, Get, Param, Res, HttpStatus, Post, Body, Put, Query, UseGuards, Req } from '@nestjs/common'
import { Response } from 'express';
import { ParseIntPipe } from '@nestjs/common/pipes/parse-int.pipe';
import { ClientDto } from './client.dto'
import { ClientUserService } from './client.service'
import { decode } from 'jsonwebtoken'
import { AuthGuard } from '@nestjs/passport'
import { EditorGuard } from '../guard/editor.guard'

@Controller('api/v1/client')
export class ClientUserController {
    constructor(
        private readonly clientUserService: ClientUserService
    ){}
    @UseGuards(EditorGuard)
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
    @Get('myDetail')
    async getMe(@Req() req:any, @Res() res: Response) {
        try {
            const token = req.headers.authorization.split(' ')[1]
            const { id }: any = decode(token)
            const myDetail = await this.clientUserService.getOne(id)
            res.json({
                msg: 'My detail',
                data: myDetail
            })
        } catch (error) {
            throw error
        }
        
    }
    @Get('check')
    async checkExsit(@Query('login_name') login_name:string, @Res() res: Response) {
        try {
            if (!login_name) {
                res.status(HttpStatus.BAD_REQUEST).json({
                    msg: 'Params error'
                })
                return
            }
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

    @UseGuards(EditorGuard)
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

    @Put('user')
    async updateMe(@Req() req:any, @Res() res: Response, @Body() body:ClientDto) {
        try {
            const token = req.headers.authorization.split(' ')[1]
            const { id }: any = decode(token)
            await this.clientUserService.update(id, body)
            res.json({
                msg: "Ok"
            })
        } catch (error) {
            throw error
        }
    }
    @Put('changePassword')
    async changePassword(@Req() req:any, @Body('password') password:string, @Body('old_password') old_password:string, @Res() res: Response) {
        try {
            const token = req.headers.authorization.split(' ')[1]
            const { id }: any = decode(token)
            if (await this.clientUserService.checkPassword(id, old_password)) {
                await this.clientUserService.update(id, { password })
                res.json({ msg: 'Ok' })
            } else {
                res.json({ code: 20003, msg: 'Old password error' })
            }
        } catch (err) {
            throw err
        }
    }
}
