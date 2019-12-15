import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm'

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
    is_del: number
}