import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm'
import { AuthModule } from './Auth/auth.module'
import { AdminUserModule } from './AdminUser/admin.module'
import { CategoryModule } from './Category/category.module'
import { ClientUserModule } from './ClientUser/client.module'
import { GameModule } from './Game/game.module'

@Module({
    imports: [TypeOrmModule.forRoot({
        type: 'mysql',
        host: 'localhost',
        port: 3306,
        username: 'root',
        password: '0000',
        database: 'game_strategy',
        entities: [__dirname + '/**/*.entity{.ts,.js}'],
        logging: ['query'],
        synchronize: true
    }),
        AdminUserModule,
        AuthModule,
        ClientUserModule,
        CategoryModule,
        GameModule
    ],
})
export class AppModule {}
