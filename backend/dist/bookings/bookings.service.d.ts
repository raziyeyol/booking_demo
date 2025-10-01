import { PrismaService } from '../prisma.service';
export declare class BookingsService {
    private readonly prisma;
    constructor(prisma: PrismaService);
    list(params: {
        customerId?: string;
    }): import(".prisma/client").Prisma.PrismaPromise<({
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
    create(input: {
        serviceId: string;
        staffId: string;
        start: Date;
    }): Promise<{
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
