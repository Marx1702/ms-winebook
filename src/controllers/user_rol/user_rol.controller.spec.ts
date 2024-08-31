import { Test, TestingModule } from '@nestjs/testing';
import { UserRolController } from './user_rol.controller';

describe('UserRolController', () => {
  let controller: UserRolController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [UserRolController],
    }).compile();

    controller = module.get<UserRolController>(UserRolController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
