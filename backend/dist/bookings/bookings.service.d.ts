import { PrismaService } from '../prisma.service';
export declare class BookingsService {
    private readonly prisma;
    constructor(prisma: PrismaService);
    list(params: {
        customerId?: string;
    }): import(".prisma/client").Prisma.PrismaPromise<({
        service: {
            name: string;
            id: string;
            createdAt: Date;
            minutes: number;
            priceCents: number;
            popular: boolean;
            updatedAt: Date;
        };
        staff: {
            name: string;
            id: string;
            createdAt: Date;
            updatedAt: Date;
            active: boolean;
        };
    } & {
        id: string;
        createdAt: Date;
        updatedAt: Date;
        serviceId: string;
        staffId: string;
        customerId: string | null;
        startAt: Date;
        endAt: Date;
        note: string | null;
        paymentStatus: string;
    })[]>;
    create(input: {
        serviceId: string;
        staffId: string;
        start: Date;
    }): Promise<{
        service: {
            name: string;
            id: string;
            createdAt: Date;
            minutes: number;
            priceCents: number;
            popular: boolean;
            updatedAt: Date;
        };
        staff: {
            name: string;
            id: string;
            createdAt: Date;
            updatedAt: Date;
            active: boolean;
        };
    } & {
        id: string;
        createdAt: Date;
        updatedAt: Date;
        serviceId: string;
        staffId: string;
        customerId: string | null;
        startAt: Date;
        endAt: Date;
        note: string | null;
        paymentStatus: string;
    }>;
    markPaid(id: string): Promise<{
        service: {
            name: string;
            id: string;
            createdAt: Date;
            minutes: number;
            priceCents: number;
            popular: boolean;
            updatedAt: Date;
        };
        staff: {
            name: string;
            id: string;
            createdAt: Date;
            updatedAt: Date;
            active: boolean;
        };
    } & {
        id: string;
        createdAt: Date;
        updatedAt: Date;
        serviceId: string;
        staffId: string;
        customerId: string | null;
        startAt: Date;
        endAt: Date;
        note: string | null;
        paymentStatus: string;
    }>;
}
