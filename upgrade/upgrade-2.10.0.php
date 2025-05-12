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
 * Function used to update your module from previous versions to the version 2.10.0
 * Don't forget to create one file per version.
 */
function upgrade_module_2_10_0($module)
{
    $sql = [];
    /*
     * Ajout de champs
     */
    if (!$module->existColumnInTable('configurator_step', 'max_options')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . "configurator_step` 
            ADD COLUMN `max_options` INT UNSIGNED NULL DEFAULT '0' AFTER `multiple`;";
    }

    if (!$module->existColumnInTable('configurator_step_attribute', 'impact_step_attribute_id')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_attribute` 
            ADD `impact_step_attribute_id` VARCHAR(30) NULL AFTER `impact_step_id`;';
    }

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    return true;
}
