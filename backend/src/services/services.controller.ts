import { Body, Controller, Get, Param, Patch, Post } from '@nestjs/common';
import { ServicesService } from './services.service';
import { IsBoolean, IsInt, IsOptional, IsString, Min } from 'class-validator';

class CreateServiceDto {
  @IsString() name!: string;
  @IsInt() @Min(1) minutes!: number;
  @IsInt() @Min(0) priceCents!: number;
  @IsOptional() @IsBoolean() popular?: boolean;
}

class UpdateServiceDto {
  @IsOptional() @IsString() name?: string;
  @IsOptional() @IsInt() @Min(1) minutes?: number;
  @IsOptional() @IsInt() @Min(0) priceCents?: number;
  @IsOptional() @IsBoolean() popular?: boolean;
}

@Controller('v1/services')
export class ServicesController {
  constructor(private readonly svc: ServicesService) {}

  @Get()
  list() {
    return this.svc.list();
  }

  @Post()
  create(@Body() dto: CreateServiceDto) {
    return this.svc.create(dto);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() dto: UpdateServiceDto) {
    return this.svc.update(id, dto);
  }
}
