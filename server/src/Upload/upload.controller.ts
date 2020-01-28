import { Controller, Post, Res, UseInterceptors, UploadedFile } from '@nestjs/common'
import { FileInterceptor } from '@nestjs/platform-express'
import { Response } from 'express';
import { UploaderService } from './upload.service'
import getIp from '../utils/getIp'

@Controller('/api/v1/upload')
export class UploaderController {
    constructor(private readonly uploaderService: UploaderService) {}
    @Post()
    @UseInterceptors(FileInterceptor('file'))
    async upload(@UploadedFile() file: any, @Res() res: Response) {
        const path = await this.uploaderService.saveFile(file)
        res.json({
            path
        })
    }
    @Post('/avatar')
    @UseInterceptors(FileInterceptor('file'))
    async uploadAvatar(@UploadedFile() file: any, @Res() res: Response) {
        const path = await this.uploaderService.saveFile(file)
        res.json({
            path: `http://${getIp()}${path}`
        })
    }
}