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
function upgrade_module_2_1_0($module)
{
    $sql = [];
    /*
     * Ajout champ
     */
    if (!$module->existColumnInTable('configurator_step', 'use_division')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step` 
            ADD COLUMN `use_division` TINYINT(1) UNSIGNED NULL DEFAULT 0 AFTER `use_qty`;';
    }

    if (!$module->existColumnInTable('configurator_step', 'use_custom_template')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step` 
            ADD COLUMN `use_custom_template` TINYINT(1) UNSIGNED NULL DEFAULT 0 AFTER `use_division`;';
    }

    if (!$module->existColumnInTable('configurator_step', 'custom_template')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step` 
            ADD COLUMN `custom_template` VARCHAR( 255 ) NULL AFTER `use_custom_template`;';
    }

    if (!$module->existColumnInTable('configurator_step_attribute', 'id_configurator_step_attribute_division')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_attribute` 
            ADD COLUMN `id_configurator_step_attribute_division` int(10) unsigned 
            DEFAULT NULL AFTER `id_configurator_step`;';
    }

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    return true;
}
