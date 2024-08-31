import { Controller, Post, Delete, Param, ParseIntPipe, Body, Get } from '@nestjs/common';
import { users_roles_service } from '../../services/user_rol/user_rol.service';

@Controller('users-roles')
export class users_roles_controller {
  constructor(private readonly usersRolesService: users_roles_service) {}

  // Asignar un rol a un usuario
  @Post()
  async assignRole(@Body() assignRoleDto: { userId: number; rolId: number }) {
    const { userId, rolId } = assignRoleDto;
    return this.usersRolesService.assignRoleToUser(userId, rolId);
  }

  // Eliminar un rol de un usuario
  @Delete()
  async removeRole(@Body() removeRoleDto: { userId: number; rolId: number }) {
    const { userId, rolId } = removeRoleDto;
    return this.usersRolesService.removeRoleFromUser(userId, rolId);
  }

  // Obtener todos los roles de un usuario
  @Get(':userId')
  async getUserRoles(@Param('userId', ParseIntPipe) userId: number) {
    return this.usersRolesService.getUserRoles(userId);
  }
}
