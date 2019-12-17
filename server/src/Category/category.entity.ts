import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm'

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
    is_del: number
}