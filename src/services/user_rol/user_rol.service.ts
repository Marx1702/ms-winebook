import { Injectable } from '@nestjs/common';
import { prisma_service } from '../prisma/prisma.service'; // Asegúrate de importar el PrismaService
import { user_rol } from '@prisma/client';

@Injectable()
export class users_roles_service {
  constructor(private readonly prisma: prisma_service) {}

  // Asignar un rol a un usuario
  async assignRoleToUser(userId: number, rolId: number): Promise<user_rol> {
    return this.prisma.user_rol.create({
      data: {
        userId,
        rolId,
      },
    });
  }

 async removeRoleFromUser(userId: number, rolId: number): Promise<user_rol | null> {
    // Primero buscamos la relación
    const userRole = await this.prisma.user_rol.findFirst({
      where: {
        userId,
        rolId,
      },
    });

    // Si la relación existe, la eliminamos
    if (userRole) {
      await this.prisma.user_rol.deleteMany({
        where: {
          userId,
          rolId,
        },
      });
      return userRole;
    }

    // Si no existe, retornamos null
    return null;
  }


  // Obtener todos los roles de un usuario
  async getUserRoles(userId: number): Promise<user_rol[]> {
    return this.prisma.user_rol.findMany({
      where: {
        userId,
      },
      include: {
        rol: true
      },
    });
  }
}
