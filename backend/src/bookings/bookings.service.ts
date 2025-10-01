import { BadRequestException, Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma.service';

@Injectable()
export class BookingsService {
  constructor(private readonly prisma: PrismaService) {}

  list(params: { customerId?: string }) {
    const where = params.customerId ? { customerId: params.customerId } : {};
    return this.prisma.booking.findMany({ where, orderBy: { startAt: 'desc' }, include: { service: true, staff: true } });
  }

  async create(input: { serviceId: string; staffId: string; start: Date }) {
    const service = await this.prisma.service.findUnique({ where: { id: input.serviceId } });
    if (!service) throw new BadRequestException('Invalid serviceId');
    const start = input.start;
    const end = new Date(start.getTime() + service.minutes * 60 * 1000);

    const overlap = await this.prisma.booking.findFirst({
      where: {
        staffId: input.staffId,
        OR: [
          { startAt: { lt: end }, endAt: { gt: start } },
        ],
      },
    });
    if (overlap) throw new BadRequestException('Time slot not available');

    const booking = await this.prisma.booking.create({
      data: {
        serviceId: input.serviceId,
        staffId: input.staffId,
        startAt: start,
        endAt: end,
        paymentStatus: 'pending',
      },
      include: { service: true, staff: true },
    });
    return booking;
  }

  async markPaid(id: string) {
    return this.prisma.booking.update({ where: { id }, data: { paymentStatus: 'paid' }, include: { service: true, staff: true } });
  }
}
