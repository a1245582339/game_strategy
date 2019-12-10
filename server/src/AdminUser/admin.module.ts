import { Module } from '@nestjs/common'
import { TypeOrmModule } from '@nestjs/typeorm'
import { AdminUserService } from './admin.service'
import { AdminUserController } from './admin.controller'
import { AdminUser } from './admin.entity'

@Module({
    imports: [TypeOrmModule.forFeature([AdminUser])],
    providers: [AdminUserService],
    controllers: [AdminUserController]
})
export class AdminUserModule {}