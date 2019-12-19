import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common'
import { decode } from 'jsonwebtoken'
import { AdminUserService } from '../AdminUser/admin.service'
@Injectable()
export class AdminGuard implements CanActivate {
    constructor(
        private readonly adminUserServer: AdminUserService
    ) {}
    async canActivate(context: ExecutionContext): Promise<boolean> {
        const req = context.switchToHttp().getRequest<Request>()
        const token = req.headers['authorization']
        if (!token) return false
        const userInfo:any = decode(token.split(' ')[1])
        const { name } = userInfo
        const user = await this.adminUserServer.checkRole(name)
        return user && user.role === 1
    }
}