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
function upgrade_module_4_38_0($module)
{
    $sql = [];

    if (!$module->existColumnInTable('configurator_step_option', 'option_min_qty')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_option` ADD `option_min_qty` TEXT NULL AFTER `default_qty`;';
    }

    if (!$module->existColumnInTable('configurator_step_option', 'option_max_qty')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_option` ADD `option_max_qty` TEXT NULL AFTER `option_min_qty`;';
    }

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    return true;
}
