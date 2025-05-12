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
 * Function used to update your module from previous versions to the version 2.11.0
 * Don't forget to create one file per version.
 */
function upgrade_module_2_11_0($module)
{
    $sql = [];
    /*
     * Ajout de champs
     */
    if (!$module->existColumnInTable('configurator_step', 'max_qty')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . "configurator_step` 
            ADD `max_qty` INT UNSIGNED NULL DEFAULT '0' AFTER `use_qty`;";
    }
    if (!$module->existColumnInTable('configurator_step', 'max_qty_step_attribute_id')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . "configurator_step` 
            ADD `max_qty_step_attribute_id` INT UNSIGNED NULL DEFAULT '0' AFTER `max_qty`;";
    }

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    return true;
}
