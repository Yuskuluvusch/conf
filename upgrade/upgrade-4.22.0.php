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
function upgrade_module_4_22_0($module)
{
    $sql = [];

    if (!DMTools::existColumnInTable('attribute', 'ref_ral')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'attribute` 
            ADD `ref_ral` VARCHAR(32) NOT NULL;';
    }

    if (!$module->existColumnInTable('configurator_step_option', 'is_ralstep')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . "configurator_step_option` 
            ADD `is_ralstep` tinyint(1) DEFAULT '0';";
    }

    if (!$module->existColumnInTable('configurator_step_option', 'id_atribute_ral')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . "configurator_step_option` 
            ADD `id_atribute_ral` int DEFAULT '0';";
    }

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    return true;
}
