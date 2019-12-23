import { Entity, Column, PrimaryGeneratedColumn, ManyToOne } from 'typeorm'
import { ClientUser } from '../ClientUser/client.entity';

@Entity({
    name: 'comment'
})
export class Comment {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    content: string;

    @Column()
    userId: number;

    @Column()
    articleId: number;

    @Column()
    create_time: number;

    @Column()
    read: number;

    @Column()
    replyId: number;

    @Column()
    del: number;

    @ManyToOne(type => ClientUser, user => user.comments)
    user: ClientUser
}