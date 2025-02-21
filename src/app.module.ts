import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { user_service } from './services/user/user.service';
import { permission_service } from './services/permission/permission.service';
// import { ActionService } from './action/action.service';
// import { CompanyService } from './company/company.service';
// import { EstablishmentService } from './establishment/establishment.service';
import { users_roles_service } from './services/user_rol/user_rol.service';
import { roles_permissions_service } from './services/roles_permissions/roles_permissions.service';
// import { UserCompanyService } from './user_company/user_company.service';
import { prisma_service } from './services/prisma/prisma.service';
import { user_controller } from './controllers/user/user.controller';
import { rol_controller } from './controllers/rol/rol.controller';
//import { ActionsController } from './actions/actions.controller';
import { ActionController } from './controllers/action/action.controller';
import { permission_controller } from './controllers/permission/permission.controller';
import { CompanyController } from './controllers/company/company.controller';
import { EstablishmentController } from './controllers/establishment/establishment.controller';
import { rol_service } from './services/rol/rol.service';
import { users_roles_controller } from './controllers/user_rol/user_rol.controller';
import { roles_permissions_controller } from './controllers/roles_permissions/roles_permissions.controller';


@Module({
  imports: [],
  controllers: [AppController, user_controller, rol_controller, ActionController, permission_controller, CompanyController, EstablishmentController, users_roles_controller, roles_permissions_controller],
  providers: [AppService, user_service, prisma_service,rol_service,users_roles_service,permission_service,roles_permissions_service],
})
export class AppModule {}
