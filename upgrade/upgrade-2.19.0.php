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
 * Function used to update your module from previous versions to the version 2.19.0
 * Don't forget to create one file per version.
 */
function upgrade_module_2_19_0($module)
{
    $module->unregisterHook('actionAdminProductsListingFieldsModifier');
    $module->unregisterHook('actionAdminAttributesGroupsListingFieldsModifier');
    $module->registerHook('displayAdminCartsView');
    $module->registerHook('actionObjectCartDeleteAfter');
    $module->registerHook('actionAfterDeleteProductInCart');

    $languages = Language::getLanguages();
    $value = [];
    foreach ($languages as $language) {
        $value[$language['id_lang']] = 'Configurator';
    }
    Configuration::updateValue('CONFIGURATOR_CUSTOMIZATION_FIELD_NAME', $value);

    $sql = [];
    /*
     * Ajout champ
     */
    if (!$module->existColumnInTable('configurator_cart_detail', 'price')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_cart_detail` ADD `price` DECIMAL(20,6) NOT NULL;';
    }

    if (!$module->existColumnInTable('configurator_cart_detail', 'weight')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_cart_detail` ADD `weight` DECIMAL(20,6) NOT NULL;';
    }

    if (!$module->existColumnInTable('configurator_cart_detail', 'id_customization')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_cart_detail` ADD `id_customization` INT NOT NULL;';
    }

    if (!$module->existColumnInTable('configurator_cart_detail', 'visual_rendering')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_cart_detail` ADD `visual_rendering` LONGTEXT NULL';
    }

    if (!$module->existColumnInTable('configurator', 'id_customization_field')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator` ADD `id_customization_field` INT NOT NULL;';
    }

    $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'customized_data` 
        CHANGE `value` `value` LONGTEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL';

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    $success = true;

    $success &= $module->uninstallOverrides();
    $success &= $module->installOverrides();

    return $success;
}

/*
 * REMOVE id_product OF configurator_cart_detail
 * REMOVE attribute_key OF configurator_cart_detail
 */
