import { Controller, Get, Param, Res, HttpStatus, Post, Body, Put, Query, UseGuards } from '@nestjs/common'
import { Response } from 'express';
import { ParseIntPipe } from '@nestjs/common/pipes/parse-int.pipe';
import { CategoryService } from './category.service'
import { CategoryDto } from './category.dto'

@Controller('api/v1/category')
export class CategoryController {
    constructor(private readonly categoryService: CategoryService) {}
    @Get('/all')
    async getCateory(@Res() res: Response) {
        try {
            const categorys = await this.categoryService.getCateory()
            // const resData = categorys
        } catch (err) {
            res.status(HttpStatus.INTERNAL_SERVER_ERROR).json({
                msg: 'Server error',
                err
            })
            throw err
        }
    }
    @Post()
    async create(@Res() res: Response, @Body() body: CategoryDto) {
        try {
            await this.categoryService.create(body)
            res.json({
                msg: 'Ok'
            })
        } catch (err) {
            throw err
        }
    }
}