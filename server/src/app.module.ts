import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TypeOrmModule } from '@nestjs/typeorm'
import { RedisModule} from 'nestjs-redis'
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
  RedisModule.register({
    name: 'default',
    host: 'localhost',
    port: 6379,
    db: 0
  }),
  AdminUserModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
