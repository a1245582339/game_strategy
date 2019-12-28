import { Controller, Post, Body, Res, HttpStatus } from '@nestjs/common'
import { Response } from 'express';
import { AuthService } from './auth.service'

@Controller('/api/v1/auth')
export class AuthController {
    constructor(private readonly authService: AuthService) {}

    @Post('admin/login')
    async getAdminToken(@Body('name') name: string, @Body('password') password: string, @Res() res: Response) {
        const token = await this.authService.createAdminToken(name, password)
        if (token) {
            res.json({ token })
        } else {
            res.json({code: 40001, msg: 'Name or Password error!'})
        }
    }

    @Post('client/login')
    async getClientToken(@Body('login_name') login_name: string, @Body('password') password: string, @Res() res: Response) {
        const token = await this.authService.createClientToken(login_name, password)
        if (token) {
            res.json({ token })
        } else {
            res.json({code: 40001, msg: 'Name or Password error!'})
        }
    }
}