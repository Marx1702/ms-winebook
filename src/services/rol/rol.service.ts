import { Injectable } from '@nestjs/common';
import { prisma_service } from '../prisma/prisma.service'; 
import { rol } from '@prisma/client';

@Injectable()
export class rol_service {
  constructor(private readonly prisma: prisma_service) {}

  async getAllRoles(): Promise<rol[]> {
    return this.prisma.rol.findMany();
  }

  async getRoleById(id: number): Promise<rol> {
    return this.prisma.rol.findUnique({
      where: { id },
    });
  }

  async createRole(data: { name: string }): Promise<rol> {
    return this.prisma.rol.create({
      data,
    });
  }

  async updateRole(id: number, data: { name?: string }): Promise<rol> {
    return this.prisma.rol.update({
      where: { id },
      data,
    });
  }

  async deleteRole(id: number): Promise<rol> {
    return this.prisma.rol.delete({
      where: { id },
    });
  }
}
