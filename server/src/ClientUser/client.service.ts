import { Injectable } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { Repository, Like } from 'typeorm'
import { ClientUser } from './client.entity'
import { ClientDto } from './client.dto'

@Injectable()
export class ClientUserService {
    constructor(
        @InjectRepository(ClientUser)
        private readonly clientUserRepository: Repository<ClientUser>
    ) { }
    async get(payload?: ClientDto, page?: number, size?: number): Promise<[ClientUser[], number]> {
        const list = this.clientUserRepository.find({ 
            select: ['id', 'login_name', 'nick_name', 'email', 'avatar'], 
            where: { ...payload, login_name: Like(`%${payload.login_name || ''}%`), del: 0 }, 
            skip: page * size, 
            take: size 
        })
        const total = this.clientUserRepository.count({ ...payload, login_name: Like(`%${payload.login_name || ''}%`), del: 0 })
        return Promise.all([list, total])
    }
    getOne(id?: number) {
        return this.clientUserRepository.findOne({
            select: ['id', 'login_name', 'nick_name', 'email', 'avatar'],
            where: {
                id, del: 0
            }
        })
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
        return !!(await this.clientUserRepository.findOne({ login_name, del: 0 }))
    }
    async update(id: number, body: ClientDto): Promise<boolean> {
        try {
            const update = await this.clientUserRepository.update({
                id, del: 0
            }, body)
            return !!update
        } catch (err) {
            throw err
        }
    }
    async checkPassword(id: number, password: string): Promise<boolean> {
        const user = await this.clientUserRepository.findOne({ id, del: 0 })
        return user.password === password
    }
}