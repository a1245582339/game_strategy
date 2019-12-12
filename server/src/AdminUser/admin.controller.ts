import { Controller, Get, Param, Res, HttpStatus, Post, Body } from '@nestjs/common'
import { Response } from 'express';
import { ParseIntPipe } from '@nestjs/common/pipes/parse-int.pipe';
import { AdminUserService } from './admin.service'
import { AdminDto } from './admin.dto';

@Controller('api/v1/admin')
export class AdminUserController {
    constructor(
        private readonly adminUserService: AdminUserService
    ){}
    @Get('/:id')
    async get(@Param('id', new ParseIntPipe()) id, @Res() res: Response) {
        console.log(id)
        try {
            const adminList = await this.adminUserService.get(id)
            res.json({
                code: 20000,
                msg: 'Admin',
                data: adminList[0]
            })
        } catch (err) {
            res.status(HttpStatus.INTERNAL_SERVER_ERROR).json({
                code: 50000,
                msg: 'Server error',
                data: err
            })
            throw err
        }
    }
    @Get()
    async getAll(@Res() res: Response) {
        try {
            const adminList = await this.adminUserService.get()
            res.json({
                code: 20000,
                msg: 'Admin list',
                data: adminList
            })
        } catch (err) {
            res.status(HttpStatus.INTERNAL_SERVER_ERROR).json({
                code: 50000,
                msg: 'Server error',
                data: err
            })
            throw err
        }
    }

    @Post()
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
                code: 50000,
                msg: 'Server error',
                data: err
            })
            throw err
        }
    }
}