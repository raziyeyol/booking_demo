import { Body, Controller, Get, Param, Patch, Post } from '@nestjs/common';
import { IsBoolean, IsOptional, IsString } from 'class-validator';
import { StaffService } from './staff.service';

class CreateStaffDto {
  @IsString() name!: string;
  @IsOptional() @IsBoolean() active?: boolean;
}

class UpdateStaffDto {
  @IsOptional() @IsString() name?: string;
  @IsOptional() @IsBoolean() active?: boolean;
}

@Controller('v1/staff')
export class StaffController {
  constructor(private readonly svc: StaffService) {}

  @Get()
  list() {
    return this.svc.list();
  }

  @Post()
  create(@Body() dto: CreateStaffDto) {
    return this.svc.create(dto);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() dto: UpdateStaffDto) {
    return this.svc.update(id, dto);
  }
}
