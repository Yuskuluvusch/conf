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
function upgrade_module_3_5_0($module)
{
    $sql = [];

    if (!$module->existColumnInTable('configurator_step', 'use_upload_camera')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . "configurator_step` 
            ADD `use_upload_camera` TINYINT(1) UNSIGNED NULL DEFAULT '0';";
    }
    if (!$module->existColumnInTable('configurator_step', 'show_upload_image')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . "configurator_step` 
            ADD `show_upload_image` TINYINT(1) UNSIGNED NULL DEFAULT '0';";
    }

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    return true;
}
