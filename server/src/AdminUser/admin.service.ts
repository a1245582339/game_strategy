import { Injectable } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { Repository } from 'typeorm'
import { AdminUser } from './admin.entity'
import { AdminDto } from './admin.dto';

@Injectable()
export class AdminUserService {
    constructor(
        @InjectRepository(AdminUser)
        private readonly adminUserRepository: Repository<AdminUser>,
    ) { }
    get(payload?: AdminDto): Promise<AdminUser[]> {
        return this.adminUserRepository.find({ select: ['id', 'name', 'role'], where: {...payload, is_del: 0} })
    }
    async checkExist(name: string): Promise<boolean> {
        return !!(await this.adminUserRepository.findOne({ name, is_del: 0 }))
    }
    async checkRole(name: string): Promise<boolean> {
         const user = await this.adminUserRepository.findOne({ name, is_del: 0 })
         return user.role === 1
    }
    async create(body: AdminDto): Promise<AdminUser | boolean> {
        try {
            const exist = await this.checkExist(body.name)
            if (exist) {
                return false
            } else {
                return this.adminUserRepository.save(body)
            }
        } catch (err) {
            throw err
        }

    }
    async update(id: number, body: AdminDto): Promise<boolean> {
        try {
            const update = await this.adminUserRepository.update({
                id,
                is_del: 0
            }, body)
            if (update) {
                return true
            }
        } catch (err) {
            throw err
        }
    }
}