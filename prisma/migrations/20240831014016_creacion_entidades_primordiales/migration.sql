/*
  Warnings:

  - You are about to drop the column `permisoId` on the `action` table. All the data in the column will be lost.
  - You are about to drop the column `permisoId` on the `rolespermissions` table. All the data in the column will be lost.
  - You are about to drop the `_rolespermissionstousuariorol` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `permiso` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `usuario` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `usuariorol` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `permissionId` to the `Action` table without a default value. This is not possible if the table is not empty.
  - Added the required column `permissionId` to the `RolesPermissions` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `_rolespermissionstousuariorol` DROP FOREIGN KEY `_RolesPermissionsToUsuarioRol_A_fkey`;

-- DropForeignKey
ALTER TABLE `_rolespermissionstousuariorol` DROP FOREIGN KEY `_RolesPermissionsToUsuarioRol_B_fkey`;

-- DropForeignKey
ALTER TABLE `action` DROP FOREIGN KEY `Action_permisoId_fkey`;

-- DropForeignKey
ALTER TABLE `rolespermissions` DROP FOREIGN KEY `RolesPermissions_permisoId_fkey`;

-- DropForeignKey
ALTER TABLE `usercompany` DROP FOREIGN KEY `UserCompany_userId_fkey`;

-- DropForeignKey
ALTER TABLE `usuariorol` DROP FOREIGN KEY `UsuarioRol_rolId_fkey`;

-- DropForeignKey
ALTER TABLE `usuariorol` DROP FOREIGN KEY `UsuarioRol_usuarioId_fkey`;

-- AlterTable
ALTER TABLE `action` DROP COLUMN `permisoId`,
    ADD COLUMN `permissionId` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `rolespermissions` DROP COLUMN `permisoId`,
    ADD COLUMN `permissionId` INTEGER NOT NULL;

-- DropTable
DROP TABLE `_rolespermissionstousuariorol`;

-- DropTable
DROP TABLE `permiso`;

-- DropTable
DROP TABLE `usuario`;

-- DropTable
DROP TABLE `usuariorol`;

-- CreateTable
CREATE TABLE `User` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `delete_at` DATETIME(3) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `User_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `UserRol` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `rolId` INTEGER NOT NULL,

    INDEX `user_idx`(`userId`),
    INDEX `role_idx`(`rolId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Permission` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_RolesPermissionsToUserRol` (
    `A` INTEGER NOT NULL,
    `B` INTEGER NOT NULL,

    UNIQUE INDEX `_RolesPermissionsToUserRol_AB_unique`(`A`, `B`),
    INDEX `_RolesPermissionsToUserRol_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE INDEX `permiso_idx` ON `Action`(`permissionId`);

-- CreateIndex
CREATE INDEX `permission_idx` ON `RolesPermissions`(`permissionId`);

-- AddForeignKey
ALTER TABLE `UserRol` ADD CONSTRAINT `UserRol_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `UserRol` ADD CONSTRAINT `UserRol_rolId_fkey` FOREIGN KEY (`rolId`) REFERENCES `Rol`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `RolesPermissions` ADD CONSTRAINT `RolesPermissions_permissionId_fkey` FOREIGN KEY (`permissionId`) REFERENCES `Permission`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Action` ADD CONSTRAINT `Action_permissionId_fkey` FOREIGN KEY (`permissionId`) REFERENCES `Permission`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `UserCompany` ADD CONSTRAINT `UserCompany_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_RolesPermissionsToUserRol` ADD CONSTRAINT `_RolesPermissionsToUserRol_A_fkey` FOREIGN KEY (`A`) REFERENCES `RolesPermissions`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_RolesPermissionsToUserRol` ADD CONSTRAINT `_RolesPermissionsToUserRol_B_fkey` FOREIGN KEY (`B`) REFERENCES `UserRol`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
