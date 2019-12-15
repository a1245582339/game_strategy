import { Module } from '@nestjs/common'
import { TypeOrmModule } from '@nestjs/typeorm'
import { ClientUserService } from './client.service'
import { ClientUserController } from './client.controller'
import { ClientUser } from './client.entity'

@Module({
    imports: [TypeOrmModule.forFeature([ClientUser])],
    providers: [ClientUserService],
    controllers: [ClientUserController],
    exports: [ClientUserService]
})
export class ClientUserModule {}