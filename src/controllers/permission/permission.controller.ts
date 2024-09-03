import { Controller, Get, Post, Patch, Delete, Param, Body, ParseIntPipe } from '@nestjs/common';
import { permission_service } from '../../services/permission/permission.service';

@Controller('permission')
export class permission_controller {
  constructor(private readonly permissionsService: permission_service) {}

  // Crear un nuevo permiso
  @Post()
  async createPermission(@Body('name') name: string) {
    return this.permissionsService.createPermission(name);
  }

  // Obtener todos los permisos
  @Get()
  async getAllPermissions() {
    return this.permissionsService.getAllPermissions();
  }

  // Obtener un permiso por ID
  @Get(':id')
  async getPermissionById(@Param('id', ParseIntPipe) id: number) {
    return this.permissionsService.getPermissionById(id);
  }

  // Actualizar un permiso por ID
  @Patch(':id')
  async updatePermission(
    @Param('id', ParseIntPipe) id: number,
    @Body('name') name: string,
  ) {
    return this.permissionsService.updatePermission(id, name);
  }

  // Eliminar un permiso por ID
  @Delete(':id')
  async deletePermission(@Param('id', ParseIntPipe) id: number) {
    return this.permissionsService.deletePermission(id);
  }
}
