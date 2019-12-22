import { Entity, Column, PrimaryGeneratedColumn, OneToMany } from 'typeorm'
import { Follow } from '../Follow/follow.entity'

@Entity({
    name: 'user'
})
export class ClientUser {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    login_name: string;

    @Column()
    nick_name: string;

    @Column()
    password: string;

    @Column()
    email: string;

    @Column({ default: 0 })
    del: number

    @OneToMany(type => Follow, follow => follow.user)
    follows: Follow[]
}