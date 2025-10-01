import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma.service';

@Injectable()
export class StaffService {
  constructor(private readonly prisma: PrismaService) {}

  list() {
    return this.prisma.staff.findMany({ orderBy: { createdAt: 'desc' } });
  }

  create(dto: { name: string; active?: boolean }) {
    return this.prisma.staff.create({ data: dto });
  }

  update(id: string, dto: Partial<{ name: string; active?: boolean }>) {
    return this.prisma.staff.update({ where: { id }, data: dto });
  }
}
