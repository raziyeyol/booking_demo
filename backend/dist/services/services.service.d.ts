import { PrismaService } from '../prisma.service';
export declare class ServicesService {
    private readonly prisma;
    constructor(prisma: PrismaService);
    list(): import(".prisma/client").Prisma.PrismaPromise<{
        name: string;
        id: string;
        createdAt: Date;
        minutes: number;
        priceCents: number;
        popular: boolean;
        updatedAt: Date;
    }[]>;
    create(dto: {
        name: string;
        minutes: number;
        priceCents: number;
        popular?: boolean;
    }): import(".prisma/client").Prisma.Prisma__ServiceClient<{
        name: string;
        id: string;
        createdAt: Date;
        minutes: number;
        priceCents: number;
        popular: boolean;
        updatedAt: Date;
    }, never, import("@prisma/client/runtime/library").DefaultArgs>;
    update(id: string, dto: Partial<{
        name: string;
        minutes: number;
        priceCents: number;
        popular?: boolean;
    }>): import(".prisma/client").Prisma.Prisma__ServiceClient<{
        name: string;
        id: string;
        createdAt: Date;
        minutes: number;
        priceCents: number;
        popular: boolean;
        updatedAt: Date;
    }, never, import("@prisma/client/runtime/library").DefaultArgs>;
}
