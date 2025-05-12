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
 * Function used to update your module from previous versions to the version 1.1.0
 * Don't forget to create one file per version.
 */
function upgrade_module_1_2_0($module)
{
    $sql = [];
    /*
     * Ajout champ
     */
    if (!$module->existColumnInTable('configurator', 'visual_rendering')) {
        $sql[] = 'ALTER TABLE  `' . _DB_PREFIX_ . 'configurator` ADD `visual_rendering` tinyint(1) DEFAULT 0;';
    }

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }
    /*
     * New hook pour les nouvelles options de personnalisation visuelle
     */
    $module->registerHook('actionProductUpdate');

    return true;
}
