import { Module } from '@nestjs/common'
import { TypeOrmModule } from '@nestjs/typeorm'
import { Comment } from './comment.entity';
import { CommentController } from './comment.controller'
import { CommentService } from './comment.service'
import { CommentGateway } from './comment.gateway'
import { ClientUserModule } from '../ClientUser/client.module'

@Module({
    imports: [TypeOrmModule.forFeature([Comment]), ClientUserModule],
    providers: [CommentService, CommentGateway],
    controllers: [CommentController]
})
export class CommentModule {}