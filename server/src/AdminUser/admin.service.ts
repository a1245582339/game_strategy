import { Injectable } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { Repository } from 'typeorm'
import { AdminUser } from './admin.entity'
import * as redis from 'redis';

@Injectable()
export class AdminUserService {
    constructor(
        @InjectRepository(AdminUser)
        private readonly adminUserRepository: Repository<AdminUser>
    ) {}
    async findAll(): Promise<AdminUser[]> {
        return await this.adminUserRepository.find()
    }
    async findRedis(): Promise<any> {
        const client = redis.createClient();
        const res = client.get('test') 
        console.log(res)
        return res
    }
}