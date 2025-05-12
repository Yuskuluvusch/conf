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
function upgrade_module_4_20_3($module)
{
    $sql = [];

    if (!$module->existColumnInTable('configurator', 'hide_button_add_to_cart')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator` '
            . 'ADD `hide_button_add_to_cart` tinyint(1) DEFAULT 0  AFTER `hide_qty_product`;';
    }

    if (!$module->existColumnInTable('configurator', 'hide_product_price')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator` '
            . 'ADD `hide_product_price` tinyint(1) DEFAULT 0  AFTER `hide_button_add_to_cart`;';
    }

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    Configuration::updateValue('CONFIGURATOR_FLOATING_PREVIEW', 0);

    return true;
}
