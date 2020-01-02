import { Injectable } from '@nestjs/common'
import { createWriteStream } from 'fs'
import { join, extname, parse } from 'path';

@Injectable()
export class UploaderService {
    constructor() {}
    async saveFile(file: any) {
        const filename = 'img_' + Date.now() + Math.random().toString(36).substr(2) + parse(file.originalname).ext   // 拓展名
            .toLocaleLowerCase();   // 一律转为小写
        const path = join(process.cwd(), 'public', `${filename}`)
        const writeImage = createWriteStream(path)
        writeImage.write(file.buffer)
        return `http://localhost:3000/public/${filename}`
    }
}