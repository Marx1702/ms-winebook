import { Injectable } from '@nestjs/common';
import { prisma_service } from '../prisma/prisma.service'; // Importa PrismaService
import { user } from '@prisma/client';

@Injectable()
export class user_service {
  constructor(private readonly prisma: prisma_service) {}

  async getAllUsers(): Promise<user[]> {
    return this.prisma.user.findMany();
  }

  async getUserById(id: number): Promise<user> {
    return this.prisma.user.findUnique({
      where: { id },
    });
  }

  async createUser(data: { username: string; email: string; name: string }): Promise<user> {
    return this.prisma.user.create({
      data,
    });
  }

  async updateUser(id: number, data: { username?: string; email?: string; name?: string }): Promise<user> {
    return this.prisma.user.update({
      where: { id },
      data,
    });
  }

  async deleteUser(id: number): Promise<user> {
    return this.prisma.user.delete({
      where: { id },
    });
  }
}
