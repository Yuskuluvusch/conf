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
 * Function used to update your module from previous versions to the version 4.7.0
 * Don't forget to create one file per version.
 *
 * @param ModuleCore $module
 *
 * @return bool
 */
function upgrade_module_4_7_0($module)
{
    $sql = [];

    if (!$module->existColumnInTable('configurator_step_tab', 'position')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_tab` ADD `position` INT NULL;';
    }

    if (!$module->existColumnInTable('configurator_step', 'max_weight_total')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step` '
            . 'ADD `max_weight_total` INT(10) UNSIGNED NULL DEFAULT 1;';
    }

    if (!$module->existColumnInTable('configurator_step', 'weight')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step` ADD `weight` TEXT NULL;';
    }

    if (!$module->existColumnInTable('configurator_step_option', 'used_for_dimension')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_option` ADD `used_for_dimension` VARCHAR(20) NULL;';
    }

    $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_option` CHANGE `weight` `weight` TEXT NULL;';

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    return true;
}
