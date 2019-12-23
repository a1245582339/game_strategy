import { Injectable } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { Repository } from 'typeorm'
import { Favorties } from './favorites.entity';

@Injectable()
export class FavortiesService {
    constructor (
        @InjectRepository(Favorties)
        private readonly favortiesService: Repository<Favorties>
    ) {}
    get(userId: number, page: number = 0, size: number = 10): Promise<Favorties[]> {
        return this.favortiesService.find({
            relations: ['article'],
            where: {
                userId
            },
            skip: page * size, 
            take: size 
        })
    }
    create(userId: number, articleId: number): Promise<Favorties> {
        return this.favortiesService.save({
            userId, articleId, create_time: Date.now()
        })
    }
    async delById(id: number) {
        const del = await this.favortiesService.delete({
            id
        })
        return del
    }
    async cancel(userId: number, articleId: number) {
        const favorties = await this.favortiesService.find({
            where: {
                articleId,
                userId
            }
        })
        return this.favortiesService.remove(favorties)
    }
}