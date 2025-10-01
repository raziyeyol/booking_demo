import { BookingsService } from './bookings.service';
declare class CreateBookingDto {
    serviceId: string;
    staffId: string;
    start: string;
}
export declare class BookingsController {
    private readonly svc;
    constructor(svc: BookingsService);
    list(customerId?: string): import(".prisma/client").Prisma.PrismaPromise<({
        service: {
            id: string;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            minutes: number;
            priceCents: number;
            popular: boolean;
        };
        staff: {
            id: string;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            active: boolean;
        };
    } & {
        id: string;
        serviceId: string;
        staffId: string;
        customerId: string | null;
        startAt: Date;
        endAt: Date;
        note: string | null;
        paymentStatus: string;
        createdAt: Date;
        updatedAt: Date;
    })[]>;
    create(dto: CreateBookingDto): Promise<{
        service: {
            id: string;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            minutes: number;
            priceCents: number;
            popular: boolean;
        };
        staff: {
            id: string;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            active: boolean;
        };
    } & {
        id: string;
        serviceId: string;
        staffId: string;
        customerId: string | null;
        startAt: Date;
        endAt: Date;
        note: string | null;
        paymentStatus: string;
        createdAt: Date;
        updatedAt: Date;
    }>;
    markPaid(id: string): Promise<{
        service: {
            id: string;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            minutes: number;
            priceCents: number;
            popular: boolean;
        };
        staff: {
            id: string;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            active: boolean;
        };
    } & {
        id: string;
        serviceId: string;
        staffId: string;
        customerId: string | null;
        startAt: Date;
        endAt: Date;
        note: string | null;
        paymentStatus: string;
        createdAt: Date;
        updatedAt: Date;
    }>;
}
export {};
