import { Body, Controller, Get, Param, Post, Query } from '@nestjs/common';
import { IsISO8601, IsOptional, IsString } from 'class-validator';
import { BookingsService } from './bookings.service';

class CreateBookingDto {
  @IsString() serviceId!: string;
  @IsString() staffId!: string;
  @IsISO8601() start!: string; // ISO date string
}

@Controller('v1/bookings')
export class BookingsController {
  constructor(private readonly svc: BookingsService) {}

  @Get()
  list(@Query('customerId') customerId?: string) {
    return this.svc.list({ customerId });
  }

  @Post()
  create(@Body() dto: CreateBookingDto) {
    return this.svc.create({
      serviceId: dto.serviceId,
      staffId: dto.staffId,
      start: new Date(dto.start),
    });
  }

  @Post(':id/mark-paid')
  markPaid(@Param('id') id: string) {
    return this.svc.markPaid(id);
  }
}