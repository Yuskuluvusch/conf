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
 * Function used to update your module from previous versions to the version 4.32.0
 * Don't forget to create one file per version.
 */
function upgrade_module_4_32_0($module)
{
    $sql = [];

    if (!$module->existColumnInTable('configurator_step', 'delivery_impact')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step` ADD `delivery_impact` TEXT NULL;';
    }
    if (!$module->existColumnInTable('configurator_step_option', 'delivery_impact')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_option` ADD `delivery_impact` TEXT NULL;';
    }
    if (!$module->existColumnInTable('configurator_cart_detail', 'delivery_impact')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_cart_detail` ADD `delivery_impact` INT DEFAULT 0;';
    }

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    return true;
}
