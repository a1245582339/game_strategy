import { Entity, Column, PrimaryGeneratedColumn, ManyToOne } from 'typeorm'
import { Category } from '../Category/category.entity';
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
}