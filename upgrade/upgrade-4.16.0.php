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
 * Function used to update your module from previous versions to the version 4.16.0
 * Don't forget to create one file per version.
 *
 * @param ModuleCore $module
 *
 * @return bool
 */
function upgrade_module_4_16_0($module)
{
    $sql = [];

    if (!$module->existColumnInTable('configurator_step_option', 'max_value_if_null')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . "configurator_step_option` 
            ADD `max_value_if_null` VARCHAR(250) NULL DEFAULT '0' AFTER `qty_coeff`;";
    }

    if (!$module->existColumnInTable('configurator_step_option', 'min_value_if_null')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . "configurator_step_option` 
            ADD `min_value_if_null` VARCHAR(250) NULL DEFAULT '0' AFTER `qty_coeff`;";
    }

    if (!$module->existColumnInTable('configurator_step_option', 'is_date')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . "configurator_step_option` 
            ADD `is_date` tinyint(1) DEFAULT '0' AFTER `email`;";
    }

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    return true;
}
