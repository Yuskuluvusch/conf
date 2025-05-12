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
 * Function used to update your module from previous versions to the version 3.3.0
 * Don't forget to create one file per version.
 *
 * @param Configurator $module
 *
 * @return bool
 */
function upgrade_module_3_4_0($module)
{
    $sql = [];

    if (!$module->existColumnInTable('configurator_cart_detail', 'id_order_detail')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_cart_detail` 
            ADD `id_order_detail` INT(10) UNSIGNED NULL AFTER `id_order`;';
    }

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    return true;
}
