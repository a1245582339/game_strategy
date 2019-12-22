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
    ) {}
    get(payload?: AdminDto): Promise<AdminUser[]> {
        return this.adminUserRepository.find({ 
            select: ['id', 'name', 'role'], 
            where: { ...payload, del: 0 } 
        })
    }
    async checkExist(name: string): Promise<boolean> {
        return !!(await this.adminUserRepository.findOne({ name, del: 0 }))
    }
    async checkRole(name: string): Promise<AdminUser> {
         const user = await this.adminUserRepository.findOne({ name, del: 0 })
         return user
    }
    async create(body: AdminDto): Promise<boolean> {
        try {
            const exist = await this.checkExist(body.name)
            if (exist) {
                return false
            } else {
                return !!(await this.adminUserRepository.save(body))
            }
        } catch (err) {
            throw err
        }

    }
    async update(id: number, body: AdminDto): Promise<boolean> {
        try {
            const update = await this.adminUserRepository.update({
                id,
                del: 0
            }, body)
            return !!update
        } catch (err) {
            throw err
        }
    }
    async checkPassword(id: number, password: string): Promise<boolean> {
        const user = await this.adminUserRepository.findOne({id, del: 0})
        return user.password === password
    }
}