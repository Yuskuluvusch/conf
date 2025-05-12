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
 * Function used to update your module from previous versions to the version 4.0.0
 * Don't forget to create one file per version.
 *
 * @param ModuleCore $module
 *
 * @return bool
 */
function upgrade_module_4_0_0($module)
{
    $sqlTable = [];

    // RENAME TABLES

    if (!$module->existTableInDatabase('configurator_step_option')) {
        $sqlTable[] = 'RENAME TABLE `' . _DB_PREFIX_ . 'configurator_step_attribute` 
            TO `' . _DB_PREFIX_ . 'configurator_step_option`';
    }

    if (!$module->existTableInDatabase('configurator_step_option_lang')) {
        $sqlTable[] = 'RENAME TABLE `' . _DB_PREFIX_ . 'configurator_step_attribute_lang` 
            TO `' . _DB_PREFIX_ . 'configurator_step_option_lang`';
    }

    // First execute the update of table
    foreach ($sqlTable as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    // After the colums
    $sql = [];

    // RENAME COLUMNS

    if ($module->existColumnInTable('configurator_step', 'id_attribute_group')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step` 
            CHANGE `id_attribute_group` `id_option_group` INT(10) UNSIGNED NOT NULL';
    }

    if ($module->existColumnInTable('configurator_step', 'max_qty_step_attribute_id')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . "configurator_step` 
            CHANGE `max_qty_step_attribute_id` `max_qty_step_option_id` INT(10) UNSIGNED NULL DEFAULT '0'";
    }

    $sql[] = 'UPDATE `' . _DB_PREFIX_ . "configurator_step` SET `type` = 'attributes' WHERE `type` = 'options'";

    if ($module->existColumnInTable('configurator_step_option', 'id_configurator_step_attribute')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_option` 
            CHANGE `id_configurator_step_attribute` `id_configurator_step_option` INT(10) UNSIGNED 
            NOT NULL AUTO_INCREMENT';
    }

    if ($module->existColumnInTable('configurator_step_option', 'id_attribute')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_option` 
            CHANGE `id_attribute` `id_option` INT(10) UNSIGNED NOT NULL';
    }

    if ($module->existColumnInTable('configurator_step_option', 'id_configurator_step_attribute_division')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_option` 
            CHANGE `id_configurator_step_attribute_division` `id_configurator_step_option_division` INT(10) UNSIGNED 
            NULL DEFAULT NULL';
    }

    if ($module->existColumnInTable('configurator_step_option', 'id_impact_step_attribute_x')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_option` 
            CHANGE `id_impact_step_attribute_x` `id_impact_step_option_x` INT(10) UNSIGNED NULL DEFAULT NULL';
    }

    if ($module->existColumnInTable('configurator_step_option', 'id_impact_step_attribute_y')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_option` 
            CHANGE `id_impact_step_attribute_y` `id_impact_step_option_y` INT(10) UNSIGNED NULL DEFAULT NULL';
    }

    if (!$module->existColumnInTable('configurator_step_option', 'ipa')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_option` 
            ADD `ipa` INT(10) UNSIGNED NOT NULL DEFAULT 0 AFTER `id_option`';
        $sql[] = 'UPDATE `' . _DB_PREFIX_ . 'configurator_step_option` 
            SET `ipa` = `id_option` WHERE `id_product` > 0';
        $sql[] = 'UPDATE `' . _DB_PREFIX_ . 'configurator_step_option` 
            SET `id_option` = `id_product` WHERE `id_product` > 0';
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_option` DROP `id_product`';
    }

    if ($module->existColumnInTable('configurator_step_option_lang', 'id_configurator_step_attribute')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_option_lang` 
            CHANGE `id_configurator_step_attribute` `id_configurator_step_option` INT(10) UNSIGNED 
            NOT NULL AUTO_INCREMENT';
    }

    if ($module->existColumnInTable('configurator_step_display_condition_group', 'id_configurator_step_attribute')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_display_condition_group` 
            CHANGE `id_configurator_step_attribute` `id_configurator_step_option` INT(10) UNSIGNED NOT NULL';
    }

    // ADD COLUMNS

    if (!$module->existColumnInTable('configurator_step', 'use_shared')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step` 
            ADD `use_shared` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0';
    }

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    return true;
}
