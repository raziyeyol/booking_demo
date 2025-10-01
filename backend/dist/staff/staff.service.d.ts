import { PrismaService } from '../prisma.service';
export declare class StaffService {
    private readonly prisma;
    constructor(prisma: PrismaService);
    list(): import(".prisma/client").Prisma.PrismaPromise<{
        name: string;
        id: string;
        createdAt: Date;
        updatedAt: Date;
        active: boolean;
    }[]>;
    create(dto: {
        name: string;
        active?: boolean;
    }): import(".prisma/client").Prisma.Prisma__StaffClient<{
        name: string;
        id: string;
        createdAt: Date;
        updatedAt: Date;
        active: boolean;
    }, never, import("@prisma/client/runtime/library").DefaultArgs>;
    update(id: string, dto: Partial<{
        name: string;
        active?: boolean;
    }>): import(".prisma/client").Prisma.Prisma__StaffClient<{
        name: string;
        id: string;
        createdAt: Date;
        updatedAt: Date;
        active: boolean;
    }, never, import("@prisma/client/runtime/library").DefaultArgs>;
}
