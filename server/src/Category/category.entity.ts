import { Entity, Column, PrimaryGeneratedColumn, OneToMany } from 'typeorm'
import { Article } from '../Article/article.entity';
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

    @Column()
    cover: string

    @OneToMany(type => Article, article => article.category)
    articles: Article[]
}