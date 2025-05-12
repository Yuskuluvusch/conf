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
 * Function used to update your module from previous versions to the version 4.21.0
 * Don't forget to create one file per version.
 *
 * @param ModuleCore $module
 *
 * @return bool
 */
function upgrade_module_4_21_0($module)
{
    $sql = [];

    if (!$module->existColumnInTable('configurator_step_option', 'display_price_calculation')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . "configurator_step_option` 
            ADD `display_price_calculation` VARCHAR(100) NOT NULL DEFAULT 'with_reduc';";
    }

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    return true;
}
