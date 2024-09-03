import { Controller, Post, Get, Delete, Param, Body, ParseIntPipe } from '@nestjs/common';
import { roles_permissions_service } from '../../services/roles_permissions/roles_permissions.service';

@Controller('roles-permissions')
export class roles_permissions_controller {
  constructor(private readonly rolesPermissionsService: roles_permissions_service) {}

  // Asignar un permiso a un rol
  @Post()
  async assignPermissionToRole(
    @Body('rolId', ParseIntPipe) rolId: number,
    @Body('permissionId', ParseIntPipe) permissionId: number,
  ) {
    return this.rolesPermissionsService.assignPermissionToRole(rolId, permissionId);
  }

  // Obtener todos los permisos asignados a un rol por su rolId
  @Get('role/:rolId')
  async getPermissionsByRoleId(@Param('rolId', ParseIntPipe) rolId: number) {
    return this.rolesPermissionsService.getPermissionsByRoleId(rolId);
  }

  // Eliminar un permiso de un rol
  @Delete('role/:rolId/permission/:permissionId')
  async removePermissionFromRole(
    @Param('rolId', ParseIntPipe) rolId: number,
    @Param('permissionId', ParseIntPipe) permissionId: number,
  ) {
    return this.rolesPermissionsService.removePermissionFromRole(rolId, permissionId);
  }
}
