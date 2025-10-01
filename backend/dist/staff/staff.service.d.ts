import { PrismaService } from '../prisma.service';
export declare class StaffService {
    private readonly prisma;
    constructor(prisma: PrismaService);
    list(): import(".prisma/client").Prisma.PrismaPromise<{
        id: string;
        name: string;
        active: boolean;
        createdAt: Date;
        updatedAt: Date;
    }[]>;
    create(dto: {
        name: string;
        active?: boolean;
    }): import(".prisma/client").Prisma.Prisma__StaffClient<{
        id: string;
        name: string;
        active: boolean;
        createdAt: Date;
        updatedAt: Date;
    }, never, import("@prisma/client/runtime/library").DefaultArgs>;
    update(id: string, dto: Partial<{
        name: string;
        active?: boolean;
    }>): import(".prisma/client").Prisma.Prisma__StaffClient<{
        id: string;
        name: string;
        active: boolean;
        createdAt: Date;
        updatedAt: Date;
    }, never, import("@prisma/client/runtime/library").DefaultArgs>;
}
