import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm'
import { AuthModule } from './Auth/auth.module'
import { AdminUserModule } from './AdminUser/admin.module'
import { CategoryModule } from './Category/category.module'
import { ClientUserModule } from './ClientUser/client.module'
import { GameModule } from './Game/game.module'
import { ArticleModule } from './Article/article.module'
import { FollowModule } from './Follow/follow.module'
import { FavortiesModule } from './Favorites/favorites.module';
import { CommentModule } from './Comment/comment.module'
import { UploadModule } from './Upload/upload.module'

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
        GameModule,
        ArticleModule,
        FollowModule,
        FavortiesModule,
        CommentModule,
        UploadModule
    ],
})
export class AppModule {}
