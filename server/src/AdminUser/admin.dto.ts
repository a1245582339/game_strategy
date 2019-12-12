import { IsInt, IsString } from 'class-validator';
export class AdminDto {
    @IsString()
    readonly name: string

    @IsInt()
    readonly password: string

    @IsInt()
    readonly role: number
}