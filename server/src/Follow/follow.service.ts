import { Injectable } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { Repository } from 'typeorm'
import { Follow } from './follow.entity'

@Injectable()
export class FollowService {
    constructor(
        @InjectRepository(Follow)
        private readonly followService: Repository<Follow>
    ){}
    async get(userId: number, page: number = 0, size: number = 10): Promise<Follow[]> {
        return this.followService.find({
            relations: ['game'],
            where: {
                userId
            },
            skip: page * size, 
            take: size 
        })
    }
    async create(userId: number, gameId: number): Promise<Follow> {
        return this.followService.save({
            userId, gameId
        })
    }
    async delById(id: number) {
        return this.followService.delete({
            id
        })
    }
    async cancel(userId: number, gameId: number) {
        const follow = await this.followService.find({
            userId, gameId
        })
        return this.followService.remove(follow)
    }
}