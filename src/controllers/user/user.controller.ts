import { Controller, Get, Post, Put, Delete, Param, Body,ParseIntPipe, Patch } from '@nestjs/common';
import { user_service } from '../../services/user/user.service';

@Controller('users')
export class user_controller {
  constructor(private readonly userService: user_service) {}

  // Obtener todos los usuarios
  @Get()
  async findAll() {
    return this.userService.getAllUsers();
  }

  // Obtener un usuario por su ID
  @Get(':id')
  async findOne(@Param('id',ParseIntPipe) id: number) {
    return this.userService.getUserById(id);
  }

  // Crear un nuevo usuario
  @Post()
  async create(@Body() createUserDto: { username: string; email: string; name: string }) {
    return this.userService.createUser(createUserDto);
  }

  // Actualizar un usuario existente
  @Patch(':id')
  async update(
    @Param('id',ParseIntPipe) id: number,
    @Body() updateUserDto: { username?: string; email?: string; name?: string },
  ) {
    return this.userService.updateUser(id, updateUserDto);
  }

  // Eliminar un usuario
  @Delete(':id')
  async remove(@Param('id',ParseIntPipe) id: number) {
    return this.userService.deleteUser(id);
  }
}
