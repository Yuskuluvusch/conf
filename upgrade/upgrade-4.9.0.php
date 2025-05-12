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
 * Function used to update your module from previous versions to the version 4.8.0
 * Don't forget to create one file per version.
 *
 * @param ModuleCore $module
 *
 * @return bool
 */
function upgrade_module_4_9_0($module)
{
    $sql = [];

    if (!$module->existColumnInTable('configurator_step_lang', 'default_value_select')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_lang` '
            . 'ADD `default_value_select` VARCHAR(255) NULL  AFTER `public_name`;';
    }

    if (!$module->existColumnInTable('configurator_step_option', 'check_value')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_option` '
            . 'ADD `check_value` tinyint(1) DEFAULT 0  AFTER `force_value`;';
    }

    if (!$module->existColumnInTable('configurator', 'hide_qty_product')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator` '
            . 'ADD `hide_qty_product` tinyint(1) DEFAULT 0  AFTER `use_base_price`;';
    }

    if (!$module->existColumnInTable('configurator_step', 'min_options')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step` '
            . "ADD COLUMN `min_options` INT UNSIGNED NULL DEFAULT '0' AFTER `max_options`;";
    }

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    Configuration::updateValue('CONFIGURATOR_FLOATING_PREVIEW', 0);

    return true;
}
