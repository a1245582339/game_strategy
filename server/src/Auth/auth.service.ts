import { Injectable } from '@nestjs/common'
import { AdminUserService } from '../AdminUser/admin.service'
import { ClientUserService } from '../ClientUser/client.service'
import { JwtService } from '@nestjs/jwt'

interface IAdminInfo {
    name: string
    password: string
}
interface IClientInfo {
    login_name: string
    password: string
}

@Injectable()
export class AuthService {
    constructor(
        private readonly adminService: AdminUserService,
        private readonly clientService: ClientUserService,
        private readonly jwtService: JwtService
    ){}

    async createAdminToken(name: string, password: string) {
        const user = (await this.validateAdmin({ name, password }))[0]
        if (user) {
            const accessToken = this.jwtService.sign({ id: user.id, name, password, role: 'admin' })
            return accessToken
        } else {
            return false
        }
        
    }
    async validateAdmin(payload: IAdminInfo): Promise<any> {
        const { name, password } = payload
        return this.adminService.get({ name, password, del: 0 })
    }

    async createClientToken(login_name: string, password: string) {
        const user = (await this.validateClient({ login_name, password }))[0]
        if (user) {
            const accessToken = this.jwtService.sign({ id: user.id, login_name, password, role: 'user' })
            return accessToken
        } else {
            return false
        }
        
    }
    async validateClient(payload: IClientInfo): Promise<any> {
        return this.clientService.get(payload)
    }
}