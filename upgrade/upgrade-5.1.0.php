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

function upgrade_module_5_1_0($module)
{
    $sql = [];

    if (!$module->existColumnInTable('configurator_step', 'unit_qty_step')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step` ADD `unit_qty_step` TINYINT(1) UNSIGNED NULL DEFAULT 0;';
    }

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    return true;
}
