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

class Carrier extends CarrierCore
{
    public static function getAvailableCarrierList(
        Product $product,
        $id_warehouse,
        $id_address_delivery = null,
        $id_shop = null,
        $cart = null,
        &$error = []
    ) {
        if ($cart) {
            require_once dirname(__FILE__) . '/../../modules/configurator/classes/ConfiguratorCartDetailModel.php';

            $width = ConfiguratorCartDetailModel::getProductWidth($cart, $product);
            $height = ConfiguratorCartDetailModel::getProductHeight($cart, $product);
            $depth = ConfiguratorCartDetailModel::getProductDepth($cart, $product);

            $product->width = $width ? $width : $product->width;
            $product->height = $height ? $height : $product->height;
            $product->depth = $depth ? $depth : $product->depth;
        }

        return parent::getAvailableCarrierList($product, $id_warehouse, $id_address_delivery, $id_shop, $cart, $error);
    }
}
