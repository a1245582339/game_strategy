import { Entity, Column, PrimaryGeneratedColumn, ManyToOne } from 'typeorm'
import { Game } from '../Game/game.entity';
import { ClientUser } from '../ClientUser/client.entity'

@Entity({
    name: 'follow'
})
export class Follow {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    gameId: number;

    @Column()
    userId: number;

    @ManyToOne(type => Game, game => game.follows)
    game: Game

    @ManyToOne(type => ClientUser, user => user.follows)
    user: ClientUser
}