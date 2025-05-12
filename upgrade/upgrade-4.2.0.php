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
function upgrade_module_4_2_0($module)
{
    $sql = [];

    if (!$module->existColumnInTable('configurator', 'use_base_price')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator` 
            ADD `use_base_price` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1';
    }

    if (!$module->existColumnInTable('configurator_step', 'formula')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step` ADD `formula` TEXT';
    }

    if (!$module->existColumnInTable('configurator_step', 'formula_surface')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step` ADD `formula_surface` TEXT';
    }

    if (!$module->existColumnInTable('configurator_step_option', 'impact_formula')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_option` ADD `impact_formula` TEXT';
    }

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    return true;
}
