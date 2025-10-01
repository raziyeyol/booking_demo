import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma.service';

@Injectable()
export class ServicesService {
  constructor(private readonly prisma: PrismaService) {}

  list() {
    return this.prisma.service.findMany({ orderBy: { createdAt: 'desc' } });
  }

  create(dto: { name: string; minutes: number; priceCents: number; popular?: boolean }) {
    return this.prisma.service.create({ data: dto });
  }

  update(id: string, dto: Partial<{ name: string; minutes: number; priceCents: number; popular?: boolean }>) {
    return this.prisma.service.update({ where: { id }, data: dto });
  }
}
