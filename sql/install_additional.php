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

$sql = [];

/* * ********************
 * EDIT EXISTING PS TABLE
 * ******************** */
if (!DMTools::existColumnInTable('product', 'is_configurated')) {
    $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'product` 
    ADD `is_configurated` TINYINT( 1 ) UNSIGNED NOT NULL DEFAULT "0";';
}
if (!DMTools::existColumnInTable('attribute', 'texture_image')) {
    $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'attribute` 
    ADD `texture_image` TINYINT( 1 ) UNSIGNED NOT NULL DEFAULT "0" AFTER `color`;';
}

if (!DMTools::existColumnInTable('attribute', 'ref_ral')) {
    $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'attribute` 
    ADD `ref_ral` VARCHAR(25) AFTER `texture_image`;';
}

/* * ********************
 * EDIT NATURE OF ORDER DETAIL FIELD
 * ******************** */
$sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'order_detail` 
    CHANGE `product_name` `product_name` TEXT CHARACTER SET utf8 NOT NULL';
$sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'customized_data` 
    CHANGE `value` `value` LONGTEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL';

foreach ($sql as $query) {
    if (Db::getInstance()->execute($query) == false) {
        return false;
    }
}
