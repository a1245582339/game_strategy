import { Entity, Column, PrimaryGeneratedColumn, ManyToOne, JoinColumn } from 'typeorm'
import { Category } from '../Category/category.entity';
@Entity({
    name: 'game'
})
export class Game {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    name: string;

    @Column()
    desp: string;

    @Column()
    cover: string;

    @Column()
    categoryId: number;

    @Column({ default: 0 })
    del: number;

    @ManyToOne(type => Category, category => category.games)
    category: Category
}