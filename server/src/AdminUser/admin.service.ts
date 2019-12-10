import { Injectable, Inject } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { Repository } from 'typeorm'
import { AdminUser } from './admin.entity'
import { RedisService } from 'nestjs-redis';

@Injectable()
export class AdminUserService {
    constructor(
        @InjectRepository(AdminUser)
        private readonly adminUserRepository: Repository<AdminUser>,
        private readonly redisService: RedisService,
    ) {}
    async findAll(): Promise<AdminUser[]> {
        return await this.adminUserRepository.find()
    }
    async findRedis(): Promise<any> {
        return await this.redisService.getClient('default')
    }
}