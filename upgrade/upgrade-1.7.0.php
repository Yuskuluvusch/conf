<?php
/**
 * 2023 DMConcept
 *
 * NOTICE OF LICENSE
 *
 * This file is licenced under the Software License Agreement.
 * With the purchase or the installation of the software in your application
 * you accept the licence agreement
 *
 * @author    DMConcept <support@dmconcept.fr>
 * @copyright 2023 DMConcept
 * @license   Commercial license (You can not resell or redistribute this software.)
 */
if (!defined('_PS_VERSION_')) {
    exit;
}

/**
 * Function used to update your module from previous versions to the version 1.7.0
 * Don't forget to create one file per version.
 */
function upgrade_module_1_7_0($module)
{
    $sql = [];
    /*
     * Ajout champ
     */
    if (!$module->existColumnInTable('configurator_step', 'type')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step` 
            ADD COLUMN `type` VARCHAR(20) NOT NULL AFTER `id_attribute_group`';
    }

    if (!$module->existColumnInTable('configurator_step', 'nb_files')) {
        $sql[] = ' ALTER TABLE `' . _DB_PREFIX_ . "configurator_step` 
            ADD COLUMN `nb_files` INT UNSIGNED NULL DEFAULT '1' AFTER `type`";
    }

    if (!$module->existColumnInTable('configurator_step', 'extensions')) {
        $sql[] = ' ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step` 
            ADD COLUMN `extensions` TEXT NULL AFTER `nb_files`;';
    }

    $sql[] = 'UPDATE `' . _DB_PREFIX_ . "configurator_step` SET `type`='options';";

    $sql[] = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'configurator_attachment` (
        `id_configurator_attachment` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
        `file` VARCHAR(40) NOT NULL,
        `file_name` VARCHAR(128) NOT NULL,
        `file_size` BIGINT(10) UNSIGNED NOT NULL DEFAULT 0,
        `mime` VARCHAR(128) NOT NULL,
        `token` VARCHAR(50) NOT NULL,
        PRIMARY KEY (`id_configurator_attachment`)
    ) ENGINE=' . _MYSQL_ENGINE_ . ' DEFAULT CHARSET=utf8;';

    $sql[] = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'configurator_cartdetail_attachment` (
        `id_configurator_cart_detail` INT(10) UNSIGNED NOT NULL,
        `id_step` INT(10) UNSIGNED NOT NULL,
        `id_configurator_attachment` INT(10) UNSIGNED NOT NULL,
        PRIMARY KEY (`id_configurator_cart_detail`, `id_configurator_attachment`, `id_step`)
    ) ENGINE=' . _MYSQL_ENGINE_ . ' DEFAULT CHARSET=utf8;';

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    return true;
}
