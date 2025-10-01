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
        name: string;
        id: string;
        createdAt: Date;
        updatedAt: Date;
        active: boolean;
    }[]>;
    create(dto: CreateStaffDto): import(".prisma/client").Prisma.Prisma__StaffClient<{
        name: string;
        id: string;
        createdAt: Date;
        updatedAt: Date;
        active: boolean;
    }, never, import("@prisma/client/runtime/library").DefaultArgs>;
    update(id: string, dto: UpdateStaffDto): import(".prisma/client").Prisma.Prisma__StaffClient<{
        name: string;
        id: string;
        createdAt: Date;
        updatedAt: Date;
        active: boolean;
    }, never, import("@prisma/client/runtime/library").DefaultArgs>;
}
export {};
