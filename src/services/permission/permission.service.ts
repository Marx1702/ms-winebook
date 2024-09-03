import { Injectable } from '@nestjs/common';
import { prisma_service } from '../../services/prisma/prisma.service';
import { permission } from '@prisma/client';

@Injectable()
export class permission_service {
  constructor(private readonly prisma: prisma_service) {}

  // Crear un nuevo permiso
  async createPermission(name: string): Promise<permission> {
    return this.prisma.permission.create({
      data: {
        name,
      },
    });
  }

  // Obtener todos los permisos
  async getAllPermissions(): Promise<permission[]> {
    return this.prisma.permission.findMany();
  }

  // Obtener un permiso por ID
  async getPermissionById(id: number): Promise<permission | null> {
    return this.prisma.permission.findUnique({
      where: { id },
    });
  }

  // Actualizar un permiso por ID
  async updatePermission(id: number, name: string): Promise<permission> {
    return this.prisma.permission.update({
      where: { id },
      data: { name },
    });
  }

  // Eliminar un permiso por ID
  async deletePermission(id: number): Promise<permission> {
    return this.prisma.permission.delete({
      where: { id },
    });
  }
}
