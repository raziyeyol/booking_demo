import { StaffService } from './staff.service';
declare class CreateStaffDto {
    name: string;
    active?: boolean;
}
declare class UpdateStaffDto {
    name?: string;
    active?: boolean;
}
export declare class StaffController {
    private readonly svc;
    constructor(svc: StaffService);
    list(): import(".prisma/client").Prisma.PrismaPromise<{
        id: string;
        name: string;
        active: boolean;
        createdAt: Date;
        updatedAt: Date;
    }[]>;
    create(dto: CreateStaffDto): import(".prisma/client").Prisma.Prisma__StaffClient<{
        id: string;
        name: string;
        active: boolean;
        createdAt: Date;
        updatedAt: Date;
    }, never, import("@prisma/client/runtime/library").DefaultArgs>;
    update(id: string, dto: UpdateStaffDto): import(".prisma/client").Prisma.Prisma__StaffClient<{
        id: string;
        name: string;
        active: boolean;
        createdAt: Date;
        updatedAt: Date;
    }, never, import("@prisma/client/runtime/library").DefaultArgs>;
}
export {};
