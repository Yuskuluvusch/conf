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
function upgrade_module_1_1_0($module)
{
    $sql = [];
    /*
     * Ajout fonctionnalité min-max pricelist
     */
    if (!$module->existColumnInTable('configurator_step_display_condition', 'min')) {
        $sql[] = 'ALTER TABLE  `' . _DB_PREFIX_ . "configurator_step_display_condition` 
            ADD `min` DECIMAL(20,6) UNSIGNED DEFAULT '0.000000', 
            ADD `max` DECIMAL(20,6) UNSIGNED DEFAULT '0.000000' ;";
    }
    /*
     * Correction TEXT => MEDIUMTEXT
     */
    $sql[] = 'ALTER TABLE  `' . _DB_PREFIX_ . 'configurator_step` 
        CHANGE `price_list` `price_list` MEDIUMTEXT CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL;';
    $sql[] = 'ALTER TABLE  `' . _DB_PREFIX_ . 'configurator_step_attribute` 
        CHANGE `price_list` `price_list` MEDIUMTEXT CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL;';
    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }
    /*
     * New hook pour l'affichage de la configuration dans le bloc panier
     * + Email contenu de la configuration depuis 1.6.1.0
     */
    $module->registerHook('displayFooter');
    $module->registerHook('actionGetExtraMailTemplateVars');

    return true;
}
