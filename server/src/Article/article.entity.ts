import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm'

@Entity({
    name: 'article'
})
export class Article {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    name: string;

    @Column()
    content: string;
}