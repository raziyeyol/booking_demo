"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.BookingsService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma.service");
let BookingsService = class BookingsService {
    constructor(prisma) {
        this.prisma = prisma;
    }
    list(params) {
        const where = params.customerId ? { customerId: params.customerId } : {};
        return this.prisma.booking.findMany({ where, orderBy: { startAt: 'desc' }, include: { service: true, staff: true } });
    }
    async create(input) {
        const service = await this.prisma.service.findUnique({ where: { id: input.serviceId } });
        if (!service)
            throw new common_1.BadRequestException('Invalid serviceId');
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
        if (overlap)
            throw new common_1.BadRequestException('Time slot not available');
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
    async markPaid(id) {
        return this.prisma.booking.update({ where: { id }, data: { paymentStatus: 'paid' }, include: { service: true, staff: true } });
    }
};
exports.BookingsService = BookingsService;
exports.BookingsService = BookingsService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], BookingsService);
//# sourceMappingURL=bookings.service.js.map