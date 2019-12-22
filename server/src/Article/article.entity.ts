import { Entity, Column, PrimaryGeneratedColumn, ManyToOne } from 'typeorm'
import { Game } from '../Game/game.entity';
@Entity({
    name: 'article'
})
export class Article {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    title: string;

    @Column()
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
}