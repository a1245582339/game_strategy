import { Controller, Get, Param, Res, HttpStatus, Post, Body, Put, Query, UseGuards } from '@nestjs/common'
import { Response } from 'express';
import { ParseIntPipe } from '@nestjs/common/pipes/parse-int.pipe';
import { AdminUserService } from './admin.service'
import { AdminDto } from './admin.dto';
import { AuthGuard } from '@nestjs/passport'
import { AdminGuard } from '../guard/admin.guard'
import { SelfGuard } from '../guard/self.guard'

@UseGuards(AuthGuard('jwt'))
@Controller('api/v1/admin')
export class AdminUserController {
    constructor(
        private readonly adminUserService: AdminUserService
    ){}
    
    @Get('user')
    async get(@Res() res: Response, @Query() query: AdminDto) {
        try {
            const adminList = await this.adminUserService.get(query)
            res.json({
                msg: 'Admin list',
                data: adminList
            })
        } catch (err) {
            throw err
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
    @Post('user')
    async create(@Res() res: Response, @Body() body:AdminDto) {
        try {
            if (await this.adminUserService.create(body)) {
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

    @UseGuards(AdminGuard)
    @Put('user/:id')
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
    @UseGuards(SelfGuard)
    @Put('changePassword/:id')
    async changePassword(@Param('id', new ParseIntPipe()) id:number, @Body('password') password:string, @Body('old_password') old_password:string, @Res() res: Response) {
        try {
            if (await this.adminUserService.checkPassword(id, old_password)) {
                await this.adminUserService.update(id, { password })
                res.json({ msg: 'Ok' })
            } else {
                res.json({ code: 20003, msg: 'Oldpassword error' })
            }
        } catch (err) {
            throw err
        }
    }
    
}