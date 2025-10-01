import { ServicesService } from './services.service';
declare class CreateServiceDto {
    name: string;
    minutes: number;
    priceCents: number;
    popular?: boolean;
}
declare class UpdateServiceDto {
    name?: string;
    minutes?: number;
    priceCents?: number;
    popular?: boolean;
}
export declare class ServicesController {
    private readonly svc;
    constructor(svc: ServicesService);
    list(): import(".prisma/client").Prisma.PrismaPromise<{
        name: string;
        id: string;
        createdAt: Date;
        minutes: number;
        priceCents: number;
        popular: boolean;
        updatedAt: Date;
    }[]>;
    create(dto: CreateServiceDto): import(".prisma/client").Prisma.Prisma__ServiceClient<{
        name: string;
        id: string;
        createdAt: Date;
        minutes: number;
        priceCents: number;
        popular: boolean;
        updatedAt: Date;
    }, never, import("@prisma/client/runtime/library").DefaultArgs>;
    update(id: string, dto: UpdateServiceDto): import(".prisma/client").Prisma.Prisma__ServiceClient<{
        name: string;
        id: string;
        createdAt: Date;
        minutes: number;
        priceCents: number;
        popular: boolean;
        updatedAt: Date;
    }, never, import("@prisma/client/runtime/library").DefaultArgs>;
}
export {};
