import { Injectable } from '@nestjs/common'
import { AdminUserService } from '../AdminUser/admin.service'
import { JwtService } from '@nestjs/jwt'

interface IAdminInfo {
    name: string
    password: string
}

@Injectable()
export class AuthService {
    constructor(
        private readonly adminService: AdminUserService,
        private readonly jwtService: JwtService
    ){}

    async createToken(name: string, password: string) {
        const user = (await this.validateAdmin({ name, password }))[0]
        if (user) {
            const accessToken = this.jwtService.sign({name, password})
            return accessToken
        } else {
            return false
        }
        
    }
    async validateAdmin(payload: IAdminInfo): Promise<any> {
        return this.adminService.get(payload)
    }
}