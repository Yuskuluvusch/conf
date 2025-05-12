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
 * Function used to update your module from previous versions to the version 3.2.0
 * Don't forget to create one file per version.
 *
 * @param Configurator $module
 *
 * @return bool
 */
function upgrade_module_3_2_0($module)
{
    $success = $module->uninstallOverrides();
    $success &= $module->installOverrides();

    $sql = [];

    if (!$module->existColumnInTable('configurator_cart_detail', 'id_product_attribute')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_cart_detail` 
            ADD `id_product_attribute` INT(10) UNSIGNED NOT NULL DEFAULT 0 AFTER `id_product`;';
    }

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    return $success;
}
