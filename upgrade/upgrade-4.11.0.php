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
function upgrade_module_4_11_0($module)
{
    $sql = [];

    if (!$module->existColumnInTable('configurator_step_option', 'slider')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_option` 
            ADD `slider` tinyint(1) DEFAULT 0 AFTER `check_value`;';
    }

    if (!$module->existColumnInTable('configurator_step_option', 'slider_step')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_option` 
            ADD `slider_step` int(10) unsigned NOT NULL DEFAULT 1 AFTER `slider`;';
    }

    if ($module->existColumnInTable('configurator_step', 'max_qty')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . "configurator_step` CHANGE `max_qty` `max_qty` VARCHAR(255) NULL DEFAULT '0';";
    }

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    return true;
}
