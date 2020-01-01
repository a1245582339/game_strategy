import { Module } from '@nestjs/common'
import { UploaderController } from  './upload.controller'
import { UploaderService } from './upload.service'

@Module({
    controllers: [UploaderController],
    providers: [UploaderService]
})
export class UploadModule {}