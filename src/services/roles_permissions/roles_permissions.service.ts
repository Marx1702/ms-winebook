import { Injectable } from '@nestjs/common';
import { prisma_service } from "../../services/prisma/prisma.service";
import { roles_permissions } from '@prisma/client';

@Injectable()
export class roles_permissions_service {
  constructor(private readonly prisma: prisma_service) {}

  // Asignar un permiso a un rol
  async assignPermissionToRole(rolId: number, permissionId: number): Promise<roles_permissions> {
    return this.prisma.roles_permissions.create({
      data: {
        rolId,
        permissionId,
      },
    });
  }

  // Obtener todos los permisos asignados a un rol
  async getPermissionsByRoleId(rolId: number): Promise<roles_permissions[]> {
    return this.prisma.roles_permissions.findMany({
      where: {
        rolId,
      },
      include: {
        permission: true, // Incluir la entidad Permission en la respuesta
      },
    });
  }

  // Eliminar un permiso de un rol
  async removePermissionFromRole(rolId: number, permissionId: number): Promise<roles_permissions | null> {
    const rolePermission = await this.prisma.roles_permissions.findFirst({
      where: {
        rolId,
        permissionId,
      },
    });

    if (rolePermission) {
      await this.prisma.roles_permissions.deleteMany({
        where: {
          rolId,
          permissionId,
        },
      });
      return rolePermission;
    }

    return null;
  }
}
