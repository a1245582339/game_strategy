import { Entity, Column, PrimaryGeneratedColumn, ManyToOne } from 'typeorm'
import { Article } from '../Article/article.entity';
import { ClientUser } from '../ClientUser/client.entity'

@Entity({
    name: 'favorties'
})
export class Favorties {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    gameId: number;

    @Column()
    userId: number;

    @ManyToOne(type => Article, article => article.favorties)
    article: Article

    @ManyToOne(type => ClientUser, user => user.favorties)
    user: ClientUser
}