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
 * @param ModuleCore $module
 *
 * @return bool
 */
function upgrade_module_3_6_0($module)
{
    $sql = [];

    // INDEXES CONFIGURATOR
    if (!$module->existIndexInTable('configurator', 'id_product')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator` ADD INDEX(`id_product`);';
    }

    // INDEXES CONFIGURATOR CART DETAIL
    if (!$module->existIndexInTable('configurator_cart_detail', 'id_configurator')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_cart_detail` ADD INDEX(`id_configurator`);';
    }
    if (!$module->existIndexInTable('configurator_cart_detail', 'id_product')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_cart_detail` ADD INDEX(`id_product`);';
    }
    if (!$module->existIndexInTable('configurator_cart_detail', 'id_product_attribute')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_cart_detail` ADD INDEX(`id_product_attribute`);';
    }
    if (!$module->existIndexInTable('configurator_cart_detail', 'id_cart')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_cart_detail` ADD INDEX(`id_cart`);';
    }
    if (!$module->existIndexInTable('configurator_cart_detail', 'id_order')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_cart_detail` ADD INDEX(`id_order`);';
    }
    if (!$module->existIndexInTable('configurator_cart_detail', 'id_order_detail')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_cart_detail` ADD INDEX(`id_order_detail`);';
    }
    if (!$module->existIndexInTable('configurator_cart_detail', 'id_customization')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_cart_detail` ADD INDEX(`id_customization`);';
    }

    // INDEXES CONFIGURATOR STEP
    if (!$module->existIndexInTable('configurator_step', 'id_configurator')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step` ADD INDEX(`id_configurator`);';
    }

    // INDEXES CONFIGURATOR STEP ATTRIBUTE
    if (!$module->existIndexInTable('configurator_step_attribute', 'id_configurator_step')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_attribute` ADD INDEX(`id_configurator_step`);';
    }
    if (!$module->existIndexInTable('configurator_step_attribute', 'id_attribute')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_attribute` ADD INDEX(`id_attribute`);';
    }
    if (!$module->existIndexInTable('configurator_step_attribute', 'id_product')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_attribute` ADD INDEX(`id_product`);';
    }

    // INDEXES CONFIGURATOR STEP CONDITION GROUP
    if (!$module->existIndexInTable(
        'configurator_step_display_condition_group',
        'id_configurator_step'
    )) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_display_condition_group` 
            ADD INDEX(`id_configurator_step`);';
    }

    // INDEXES CONFIGURATOR STEP CONDITION
    if (!$module->existIndexInTable(
        'configurator_step_display_condition',
        'id_configurator_step_display_condition_group'
    )) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_display_condition` 
            ADD INDEX(`id_configurator_step_display_condition_group`);';
    }

    // INDEXES CONFIGURATOR STEP TAB
    if (!$module->existIndexInTable('configurator_step_tab', 'id_configurator')) {
        $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_tab` ADD INDEX(`id_configurator`);';
    }

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    $success = $module->registerHook('displayAdminOrder');

    return $success;
}
