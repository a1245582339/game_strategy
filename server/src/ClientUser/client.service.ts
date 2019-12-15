import { Injectable } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { Repository } from 'typeorm'
import { ClientUser } from './client.entity'
import { ClientDto } from './client.dto'

@Injectable()
export class ClientUserService {
    constructor(
        @InjectRepository(ClientUser)
        private readonly clientUserRepository: Repository<ClientUser>
    ) {}
    get(payload?: ClientDto, page?: number, size?: number): Promise<ClientUser[]> {
        return this.clientUserRepository.find({ select: ['id', 'login_name', 'nick_name', 'email'], where: {...payload, is_del: 0}, skip: page * size, take: size })
    }
    async create(body: ClientDto): Promise<ClientUser | boolean> {
        try {
            const exist = await this.checkExist(body.login_name)
            if (exist) {
                return false
            } else {
                return !!(await this.clientUserRepository.save(body))
            }
        } catch (err) {
            throw err
        }
    }
    async checkExist(login_name: string): Promise<boolean> {
        return !!(await this.clientUserRepository.findOne({ login_name, is_del: 0 }))
    }
    async update(id: number, body: ClientDto): Promise<boolean> {
        try {
            const update = await this.clientUserRepository.update({
                id, is_del: 0
            }, body)
            return !!update
        } catch (err) {
            throw err
        }
    }
    async checkPassword(id: number, password: string): Promise<boolean> {
        const user = await this.clientUserRepository.findOne({id, is_del: 0})
        return user.password === password
    }
}