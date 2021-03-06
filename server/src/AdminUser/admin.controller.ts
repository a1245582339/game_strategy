import { Controller, Get, Param, Res, HttpStatus, Post, Body, Put, Query, UseGuards, Req } from '@nestjs/common'
import { Response, Request } from 'express';
import { ParseIntPipe } from '@nestjs/common/pipes/parse-int.pipe';
import { AdminUserService } from './admin.service'
import { AdminDto } from './admin.dto';
import { decode } from 'jsonwebtoken'
import { AuthGuard } from '@nestjs/passport'
import { AdminGuard } from '../guard/admin.guard'
import { EditorGuard } from '../guard/editor.guard'

@UseGuards(AuthGuard('jwt'))
@Controller('api/v1/admin')
export class AdminUserController {
    constructor(
        private readonly adminUserService: AdminUserService
    ){}
    
    @UseGuards(AdminGuard)
    @Get()
    async get(@Res() res: Response, @Query() query: AdminDto) {
        try {
            const adminList = await this.adminUserService.get({...query, role: 2})
            res.json({
                msg: 'Admin list',
                list: adminList
            })
        } catch (err) {
            throw err
        }
    }
    @Get('me')
    async getMyInfo(@Req() req:Request, @Res() res: Response) {
        try {
            const token = req.headers.authorization.split(' ')[1]
            const { id }: any = decode(token)
            const myInfo = await this.adminUserService.getInfo(id)
            res.json({
                msg: 'Info',
                data: myInfo
            })
        } catch (error) {
            throw error
        }
    }
    @Get('check')
    async checkExsit(@Query('name') name:string, @Res() res: Response) {
        try {
            const result = await this.adminUserService.checkExist(name)
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

    @UseGuards(AdminGuard)
    @Post()
    async create(@Res() res: Response, @Body() body:AdminDto) {
        try {
            if (await this.adminUserService.create(body)) {
                res.status(HttpStatus.CREATED).json({
                    msg: 'Ok'
                })
            } else {
                res.json({
                    code: 20009,
                    msg: 'Name exist'
                })
            }
            
        } catch (err) {
            throw err
        }
    }

    @UseGuards(AdminGuard)
    @Put('/:id')
    async update(@Param('id', new ParseIntPipe()) id:number, @Body() body:AdminDto, @Res() res: Response) {
        try {
            await this.adminUserService.update(id, body)
            res.json({
                msg: "Ok"
            })
        } catch (err) {
            throw err
        }
    }

    @Post('/changePassword')
    async changePassword(@Req() req:Request, @Body('password') password:string, @Body('old_password') old_password:string, @Res() res: Response) {
        try {
            const token = req.headers.authorization.split(' ')[1]
            const { id }: any = decode(token)
            
            if (await this.adminUserService.checkPassword(id, old_password)) {
                await this.adminUserService.update(id, { password })
                res.json({ msg: 'Ok' })
            } else {
                res.json({ code: 20003, msg: 'Old password error' })
            }
        } catch (err) {
            throw err
        }
    }
    
}