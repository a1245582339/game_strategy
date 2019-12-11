import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm'
import { AdminUserModule } from './AdminUser/admin.module';

@Module({
  imports: [TypeOrmModule.forRoot({
    type: 'mysql',
    host: 'localhost',
    port: 3306,
    username: 'root',
    password: '0000',
    database: 'game_strategy',
    entities: [__dirname + '/**/*.entity{.ts,.js}'],
    synchronize: true
  }), 
  AdminUserModule],
})
export class AppModule {}
