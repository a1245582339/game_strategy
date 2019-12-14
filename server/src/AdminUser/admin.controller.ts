import { Controller, Get, Param, Res, HttpStatus, Post, Body, Put, Query, UseGuards } from '@nestjs/common'
import { Response } from 'express';
import { ParseIntPipe } from '@nestjs/common/pipes/parse-int.pipe';
import { AdminUserService } from './admin.service'
import { AdminDto } from './admin.dto';
import { AuthGuard } from '@nestjs/passport'

@UseGuards(AuthGuard('jwt'))
@Controller('api/v1/admin')
export class AdminUserController {
    constructor(
        private readonly adminUserService: AdminUserService
    ){}

    @Get('user')
    async getAll(@Res() res: Response, @Query() query: AdminDto) {
        try {
            const adminList = await this.adminUserService.get(query)
            res.json({
                msg: 'Admin list',
                data: adminList
            })
        } catch (err) {
            res.status(HttpStatus.INTERNAL_SERVER_ERROR).json({
                msg: 'Server error',
                err
            })
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
        } catch (error) {
            
        }
    }
    @Post('user')
    async create(@Res() res: Response, @Body() body:AdminDto) {
        try {
            const data = await this.adminUserService.create(body)
            if (data) {
                res.status(HttpStatus.CREATED).json({
                    msg: 'Ok'
                })
            } else {
                res.status(HttpStatus.CONFLICT).json({
                    msg: 'Name exist'
                })
            }
            
        } catch (err) {
            res.status(HttpStatus.INTERNAL_SERVER_ERROR).json({
                msg: 'Server error',
                err
            })
            throw err
        }
    }
    @Put('user/:id')
    async update(@Param('id', new ParseIntPipe()) id:number, @Body() body:AdminDto, @Res() res: Response) {
        try {
            await this.adminUserService.update(id, body)
            res.json({
                msg: "Ok"
            })
        } catch (err) {
            res.status(HttpStatus.INTERNAL_SERVER_ERROR).json({
                msg: 'Server error',
                err
            })
            throw err
        }
    }
    
}