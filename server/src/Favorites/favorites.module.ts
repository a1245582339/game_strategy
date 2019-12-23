import { Module } from '@nestjs/common'
import { TypeOrmModule } from '@nestjs/typeorm'
import { Favorties } from './favorites.entity';
import { FavortiesController } from './favorites.controller';
import { FavortiesService } from './favorites.service';

@Module({
    imports: [TypeOrmModule.forFeature([Favorties])],
    providers: [FavortiesService],
    controllers: [FavortiesController],
})
export class FavortiesModule {}