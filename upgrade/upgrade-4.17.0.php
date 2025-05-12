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
 * Function used to update your module from previous versions to the version 4.17.0
 * Don't forget to create one file per version.
 *
 * @param ModuleCore $module
 *
 * @return bool
 */
function upgrade_module_4_17_0($module)
{
    $sql = [];

    if (!$module->existColumnInTable('configurator_step_display_condition', 'formula')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_display_condition` 
            ADD `formula` TEXT NULL;';
    }

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    Configuration::updateValue('CONFIGURATOR_MODAL_CONFIRMATION_CART', 0);
    Configuration::updateValue('CONFIGURATOR_MODAL_CONFIRMATION_CART_ACCEPTATION', 0);

    return true;
}
