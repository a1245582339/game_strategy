import { Entity, Column, PrimaryGeneratedColumn, ManyToOne, OneToMany } from 'typeorm'
import { Game } from '../Game/game.entity';
import { Favorties } from '../Favorites/favorites.entity';
import { Comment } from '../Comment/comment.entity'
@Entity({
    name: 'article'
})
export class Article {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    title: string;

    @Column('longtext')
    content: string;

    @Column()
    cover: string;

    @Column()
    gameId: number;

    @Column({ default: 0 })
    del: number

    @Column()
    create_time: string

    @ManyToOne(type => Game, game => game.articles)
    game: Game

    @OneToMany(type => Favorties, favorties => favorties.article)
    favorties: Favorties[]

    @OneToMany(type => Comment, comment => comment.article)
    comments: Comment[]
}