import { Controller, Get } from '@nestjs/common'
import { AdminUserService } from './admin.service'

@Controller('admin')
export class AdminUserController {
    constructor(
        private readonly adminUserService: AdminUserService
    ){}
    @Get()
    async findAll() {
        const adminList = await this.adminUserService.findAll()
        return adminList
    }
    @Get('/abc')
    async getDetail() {
        const adminList = await this.adminUserService.findRedis()
        return adminList
    }
}