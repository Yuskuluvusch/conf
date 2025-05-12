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
function upgrade_module_4_10_0($module)
{
    $sql = [];

    if (!$module->existColumnInTable('configurator', 'tab_type')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator` '
            . "ADD `tab_type` VARCHAR(255) NOT NULL DEFAULT 'tab';";
    }

    if (!$module->existColumnInTable('configurator_step', 'dropzone')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step` ADD `dropzone` TEXT NULL;';
    }

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    return true;
}
