import { Injectable } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { Repository } from 'typeorm'
import { AdminUser } from './admin.entity'

@Injectable()
export class AdminUserService {
    constructor(
        @InjectRepository(AdminUser)
        private readonly adminUserRepository: Repository<AdminUser>
    ) {}
    async get(id?: number): Promise<AdminUser[]> {
        if (id) {
            return await this.adminUserRepository.find({ select: ['id', 'name'], where: { id, is_del: 0 } })
        } else {
            return await this.adminUserRepository.find({ select: ['id', 'name'], where: { is_del: 0 } })
        }
    }
}