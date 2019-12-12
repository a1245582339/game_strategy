import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm'

@Entity({
    name: 'admin_user'
})
export class AdminUser {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    name: string;

    @Column()
    password: string;

    @Column()
    role: number;

    @Column({default: 0})
    is_del: number
}