import { Controller, Get, Post, Put, Delete, Param, Body, ParseIntPipe, Patch } from '@nestjs/common';
import { rol_service } from '../../services/rol/rol.service';

@Controller('roles')
export class rol_controller {
  constructor(private readonly roleService: rol_service) {}

  // Obtener todos los roles
  @Get()
  async findAll() {
    return this.roleService.getAllRoles();
  }

  // Obtener un rol por su ID
  @Get(':id')
  async findOne(@Param('id', ParseIntPipe) id: number) {
    return this.roleService.getRoleById(id);
  }

  // Crear un nuevo rol
  @Post()
  async create(@Body() createRoleDto: { name: string }) {
    return this.roleService.createRole(createRoleDto);
  }

  // Actualizar un rol existente
  @Patch(':id')
  async update(@Param('id', ParseIntPipe) id: number, @Body() updateRoleDto: { name?: string }) {
    return this.roleService.updateRole(id, updateRoleDto);
  }

  // Eliminar un rol por su ID
  @Delete(':id')
  async remove(@Param('id', ParseIntPipe) id: number) {
    return this.roleService.deleteRole(id);
  }
}
