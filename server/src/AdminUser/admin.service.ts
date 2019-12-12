import { Injectable } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { Repository } from 'typeorm'
import { AdminUser } from './admin.entity'

@Injectable()
export class AdminUserService {
    constructor(
        @InjectRepository(AdminUser)
        private readonly adminUserRepository: Repository<AdminUser>,
    ) {}
    get(id?: number): Promise<AdminUser[]> {
        return this.adminUserRepository.find({ select: ['id', 'name'], where: Object.assign({ is_del: 0 }, id ? { id } : {}) })
    }
}