import { Controller, Get, Param, Res, HttpStatus } from '@nestjs/common'
import { Response } from 'express';
import { AdminUserService } from './admin.service'

@Controller('api/v1/admin')
export class AdminUserController {
    constructor(
        private readonly adminUserService: AdminUserService
    ){}
    @Get('/:id')
    async get(@Param('id') id:string, @Res() res: Response) {
        try {
            const adminList = await this.adminUserService.get(parseInt(id))
            res.json({
                code: 20000,
                msg: 'admin',
                data: adminList[0]
            })
        } catch (err) {
            res.status(HttpStatus.INTERNAL_SERVER_ERROR).json({
                code: 50000,
                msg: 'server error',
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
                msg: 'admin list',
                data: adminList
            })
        } catch (err) {
            res.status(HttpStatus.INTERNAL_SERVER_ERROR).json({
                code: 50000,
                msg: 'server error',
                data: err
            })
            throw err
        }
    }
}