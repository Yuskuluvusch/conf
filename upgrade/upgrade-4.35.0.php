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
function upgrade_module_4_35_0($module)
{
    $sql = [];

    if (!$module->existColumnInTable('configurator', 'use_combination')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator` ADD `use_combination` TINYINT(1) DEFAULT 0;';
    }

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    $success = true;

    $success &= $module->uninstallOverrides();
    $success &= $module->installOverrides();

    return $success;
}
