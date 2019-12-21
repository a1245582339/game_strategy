import { Entity, Column, PrimaryGeneratedColumn, OneToMany, JoinColumn } from 'typeorm'
import { Game } from '../Game/game.entity';
@Entity({
    name: 'category'
})
export class Category {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    p_id: number;

    @Column()
    l_id: number;

    @Column()
    r_id: number;

    @Column()
    name: string;

    @Column()
    type: number

    @Column({ default: 0 })
    del: number

    @OneToMany(type => Game, game => game.category)
    games: Game
}