import { Module } from '@nestjs/common'
import { TypeOrmModule } from '@nestjs/typeorm'
import { ClientUserService } from './client.service'
import { ClientUserController } from './client.controller'
import { ClientUser } from './client.entity'
import { AdminUserModule } from '../AdminUser/admin.module'

@Module({
    imports: [TypeOrmModule.forFeature([ClientUser]), AdminUserModule],
    providers: [ClientUserService],
    controllers: [ClientUserController],
    exports: [ClientUserService]
})
export class ClientUserModule {}