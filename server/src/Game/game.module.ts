import { Module } from '@nestjs/common'
import { TypeOrmModule } from '@nestjs/typeorm'
import { GameService } from './game.service'
import { Game } from './game.entity'
import { GameController } from './game.controller'
import { ArticleModule } from '../Article/article.module'

@Module({
    imports: [
        TypeOrmModule.forFeature([Game]),
        ArticleModule
    ],
    providers: [GameService],
    controllers: [GameController],
    exports: [GameService]
})
export class GameModule {}