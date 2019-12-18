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

    @Put('create/:id')
    async update(@Res() res: Response, @Body('name') name: string, @Param('id', new ParseIntPipe()) id:number) {
        try {
            if (await this.categoryService.update(id, name)) {
                res.json({
                    msg: 'Ok'
                })
            } else {
                res.json({
                    code: 20004,
                    msg: `No found category as id = ${id}`
                })
            }
        } catch (err) {
            throw err
        }
    }

    @Put('del/:id')
    async delete(@Param('id', new ParseIntPipe()) id:number, @Res() res: Response) {
        try {
            if (await this.categoryService.delete(id)) {
                res.json({
                    msg: 'Ok'
                })
            } else {
                res.json({
                    code: 20004,
                    msg: `No found category as id = ${id}`
                })
            }
        } catch (err) {
            throw err
        }
    }
}