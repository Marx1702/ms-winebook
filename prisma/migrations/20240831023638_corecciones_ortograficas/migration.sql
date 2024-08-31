/*
  Warnings:

  - You are about to drop the column `permisoId` on the `action` table. All the data in the column will be lost.
  - You are about to drop the `_rolespermissionstousuariorol` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `permiso` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `rolespermissions` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `usercompany` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `usuario` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `usuariorol` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `permissionId` to the `action` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `_rolespermissionstousuariorol` DROP FOREIGN KEY `_RolesPermissionsToUsuarioRol_A_fkey`;

-- DropForeignKey
ALTER TABLE `_rolespermissionstousuariorol` DROP FOREIGN KEY `_RolesPermissionsToUsuarioRol_B_fkey`;

-- DropForeignKey
ALTER TABLE `action` DROP FOREIGN KEY `Action_permisoId_fkey`;

-- DropForeignKey
ALTER TABLE `establishment` DROP FOREIGN KEY `Establishment_companyId_fkey`;

-- DropForeignKey
ALTER TABLE `rolespermissions` DROP FOREIGN KEY `RolesPermissions_permisoId_fkey`;

-- DropForeignKey
ALTER TABLE `rolespermissions` DROP FOREIGN KEY `RolesPermissions_rolId_fkey`;

-- DropForeignKey
ALTER TABLE `usercompany` DROP FOREIGN KEY `UserCompany_companyId_fkey`;

-- DropForeignKey
ALTER TABLE `usercompany` DROP FOREIGN KEY `UserCompany_userId_fkey`;

-- DropForeignKey
ALTER TABLE `usuariorol` DROP FOREIGN KEY `UsuarioRol_rolId_fkey`;

-- DropForeignKey
ALTER TABLE `usuariorol` DROP FOREIGN KEY `UsuarioRol_usuarioId_fkey`;

-- AlterTable
ALTER TABLE `action` DROP COLUMN `permisoId`,
    ADD COLUMN `permissionId` INTEGER NOT NULL;

-- DropTable
DROP TABLE `_rolespermissionstousuariorol`;

-- DropTable
DROP TABLE `permiso`;

-- DropTable
DROP TABLE `rolespermissions`;

-- DropTable
DROP TABLE `usercompany`;

-- DropTable
DROP TABLE `usuario`;

-- DropTable
DROP TABLE `usuariorol`;

-- CreateTable
CREATE TABLE `user` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `delete_at` DATETIME(3) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `user_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_rol` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `rolId` INTEGER NOT NULL,

    INDEX `user_idx`(`userId`),
    INDEX `rol_idx`(`rolId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `permission` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `roles_permissions` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `rolId` INTEGER NOT NULL,
    `permissionId` INTEGER NOT NULL,

    INDEX `rol_idx`(`rolId`),
    INDEX `permission_idx`(`permissionId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_company` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `companyId` INTEGER NOT NULL,

    INDEX `user_idx`(`userId`),
    INDEX `company_idx`(`companyId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_roles_permissionsTouser_rol` (
    `A` INTEGER NOT NULL,
    `B` INTEGER NOT NULL,

    UNIQUE INDEX `_roles_permissionsTouser_rol_AB_unique`(`A`, `B`),
    INDEX `_roles_permissionsTouser_rol_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE INDEX `permission_idx` ON `action`(`permissionId`);

-- AddForeignKey
ALTER TABLE `user_rol` ADD CONSTRAINT `user_rol_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `user_rol` ADD CONSTRAINT `user_rol_rolId_fkey` FOREIGN KEY (`rolId`) REFERENCES `rol`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `roles_permissions` ADD CONSTRAINT `roles_permissions_rolId_fkey` FOREIGN KEY (`rolId`) REFERENCES `rol`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `roles_permissions` ADD CONSTRAINT `roles_permissions_permissionId_fkey` FOREIGN KEY (`permissionId`) REFERENCES `permission`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `action` ADD CONSTRAINT `action_permissionId_fkey` FOREIGN KEY (`permissionId`) REFERENCES `permission`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `user_company` ADD CONSTRAINT `user_company_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `user_company` ADD CONSTRAINT `user_company_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `company`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `establishment` ADD CONSTRAINT `establishment_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `company`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_roles_permissionsTouser_rol` ADD CONSTRAINT `_roles_permissionsTouser_rol_A_fkey` FOREIGN KEY (`A`) REFERENCES `roles_permissions`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_roles_permissionsTouser_rol` ADD CONSTRAINT `_roles_permissionsTouser_rol_B_fkey` FOREIGN KEY (`B`) REFERENCES `user_rol`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
