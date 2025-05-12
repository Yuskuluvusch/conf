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
 * In some cases you should not drop the tables.
 * Maybe the merchant will just try to reset the module
 * but does not want to loose all of the data associated to the module.
 */
$sql = [];
$sql[] = 'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'configurator`';
$sql[] = 'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'configurator_shop`';
$sql[] = 'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'configurator_step`';
$sql[] = 'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'configurator_step_lang`';
$sql[] = 'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'configurator_step_group`';
$sql[] = 'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'configurator_step_attribute`';
$sql[] = 'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'configurator_step_option`';
$sql[] = 'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'configurator_step_attribute_lang`';
$sql[] = 'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'configurator_step_option_lang`';
$sql[] = 'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'configurator_step_display_condition`';
$sql[] = 'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'configurator_step_display_condition_group`';
$sql[] = 'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'configurator_cart_detail`';
$sql[] = 'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'configurator_attachment`';
$sql[] = 'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'configurator_cartdetail_attachment`';
$sql[] = 'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'configurator_step_tab`';
$sql[] = 'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'configurator_step_tab_lang`';
$sql[] = 'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'configurator_step_filter`';
$sql[] = 'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'configurator_step_filter_group`';

if (DMTools::existColumnInTable('attribute', 'texture_image')) {
    $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'attribute` DROP `texture_image`';
}
if (DMTools::existColumnInTable('product', 'is_configurated')) {
    $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'product` DROP `is_configurated`';
}

if (DMTools::existColumnInTable('attribute', 'ref_ral')) {
    $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'attribute` DROP `ref_ral`';
}

foreach ($sql as $query) {
    if (Db::getInstance()->execute($query) == false) {
        return false;
    }
}
