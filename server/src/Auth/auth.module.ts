import { Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt';
import { AdminUserModule } from '../AdminUser/admin.module';
import { AuthService } from './auth.service';
import { JwtStrategy } from './jwt.strategy';
import { AuthController } from './auth.controller';
import { PassportModule } from '@nestjs/passport'

@Module({
    imports: [
        PassportModule.register({ defaultStrategy: 'jwt' }),
        JwtModule.register({
            secretOrPrivateKey: 'secret',
            signOptions: { expiresIn: '7d' },
        }),
        AdminUserModule
    ],
    providers:  [AuthService, JwtStrategy],
    controllers: [AuthController],
})
export class AuthModule {}