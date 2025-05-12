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
 * Function used to update your module from previous versions to the version 2.15.0
 * Don't forget to create one file per version.
 */
function upgrade_module_2_15_0($module)
{
    $sql = [];
    /*
     * Ajout champ
     */
    if (!$module->existColumnInTable('configurator_step', 'id_configurator_step_tab')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step` 
            ADD COLUMN `id_configurator_step_tab` INT(10) UNSIGNED NOT NULL DEFAULT 0';
    }

    $sql[] = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'configurator_step_tab` (
        `id_configurator_step_tab` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
        `id_configurator` INT(10) UNSIGNED NOT NULL,
        PRIMARY KEY (`id_configurator_step_tab`)
    ) ENGINE=' . _MYSQL_ENGINE_ . ' DEFAULT CHARSET=utf8;';

    $sql[] = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'configurator_step_tab_lang` (
        `id_configurator_step_tab` INT(10) UNSIGNED NOT NULL,
        `id_lang` INT(10) UNSIGNED NOT NULL,
        `name` VARCHAR(255),
        PRIMARY KEY (`id_configurator_step_tab`, `id_lang`)
    ) ENGINE=' . _MYSQL_ENGINE_ . ' DEFAULT CHARSET=utf8;';

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    $module = new Configurator();
    $module->_installModuleTab('AdminConfiguratorTabs', $module->l('Configurator tabs'), 0);

    return true;
}
