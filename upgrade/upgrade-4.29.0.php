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
 * Function used to update your module from previous versions to the version 4.28.0
 * Don't forget to create one file per version.
 *
 * @param ModuleCore $module
 *
 * @return bool
 */
function upgrade_module_4_29_0($module)
{
    $sql = [];

    if (!$module->existColumnInTable('configurator', 'tab_force_require_step')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator` ADD `tab_force_require_step` TINYINT(1) DEFAULT 0;';
    }

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    return true;
}
