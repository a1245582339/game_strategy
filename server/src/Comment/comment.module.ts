import { Module } from '@nestjs/common'
import { TypeOrmModule } from '@nestjs/typeorm'
import { Comment } from './comment.entity';
import { CommentController } from './comment.controller'
import { CommentService } from './comment.service'
import { CommentGateway } from './comment.gateway'

@Module({
    imports: [TypeOrmModule.forFeature([Comment])],
    providers: [CommentService, CommentGateway],
    controllers: [CommentController]
})
export class CommentModule {}