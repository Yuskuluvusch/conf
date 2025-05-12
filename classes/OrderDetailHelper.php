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

if (!defined('_CAN_LOAD_FILES_')) {
    exit;
}

if (!class_exists('OrderDetailHelper')) {
    class OrderDetailHelper
    {
        public const DECIMAL_PRECISION = 4;

        public static $tax;
        public static $orderDetails;

        public static function duplicateCart(Cart $cart, $id_order)
        {
            // Get original Cart
            /* @var $order OrderCore */
            $order = new Order((int) $id_order);

            if (Validate::isLoadedObject($cart) && Validate::isLoadedObject($order)) {
                /* @var $old_cart CartCore */
                $old_cart = new Cart((int) $order->id_cart);

                foreach ($old_cart->getProducts() as $product) {
                    $id_product = (int) $product['id_product'];

                    /* @var $configurator ConfiguratorModel */
                    $configurator = ConfiguratorModel::productHasConfigurator($product['id_product'], true, true);

                    if (Validate::isLoadedObject($configurator)) {
                        /* @var $configuratorCartDetail ConfiguratorCartDetailModel */
                        $configuratorCartDetails = ConfiguratorCartDetailModel::getMultipleByIdConfiguratorAndIdCart(
                            $configurator->id,
                            $old_cart->id
                        );
                        foreach ($configuratorCartDetails as $configuratorCartDetail) {
                            /* @var $newConfiguratorCartDetail ConfiguratorCartDetailModel */
                            $newConfiguratorCartDetail = $configuratorCartDetail->duplicateObject();
                            $newConfiguratorCartDetail->id_cart = $cart->id;
                            $newConfiguratorCartDetail->id_order_detail = 0;
                            $newConfiguratorCartDetail->id_order = 0;
                            $newConfiguratorCartDetail->id_customization = 0; // force calculate a new id_customization

                            $customization = new Customization($newConfiguratorCartDetail->id_customization);
                            if (!Validate::isLoadedObject($customization)) {
                                $customization = new Customization();
                                $customization->id_product_attribute = ($newConfiguratorCartDetail->id_product_attribute)
                                    ? $newConfiguratorCartDetail->id_product_attribute
                                    : 0;

                                $customization->id_cart = $cart->id;
                                $customization->id_address_delivery = $cart->id_address_delivery;

                                $customization->id_product = $id_product;
                                $customization->quantity = 1;
                                $customization->quantity_refunded = 0;
                                $customization->quantity_returned = 0;
                                $customization->in_cart = 1;
                                $customization->save();

                                $newConfiguratorCartDetail->id_customization = $customization->id;
                            }

                            $newConfiguratorCartDetail->setCustomization(
                                $configuratorCartDetail->price,
                                $configuratorCartDetail->weight
                            );
                            $newConfiguratorCartDetail->save();
                        }
                    }
                }
            }
        }

        public static function generateConfiguratorOrderDetail($params)
        {
            $order_detail = $params['object'];
            $product = new Product($order_detail->product_id, false);
            $order = new Order($order_detail->id_order);
            $configurationsCartDetails = ConfiguratorCartDetailModel::getMultipleByIdCartAndIdProduct(
                (int) $order->id_cart,
                (int) $product->id
            );
            if ($configurationsCartDetails) {
                foreach ($configurationsCartDetails as &$configurationCartDetail) {
                    $customization = new Customization($configurationCartDetail->id_customization);
                    if (Validate::isLoadedObject($configurationCartDetail)
                        && Validate::isLoadedObject($customization)
                        && Validate::isLoadedObject($order)
                        && Validate::isLoadedObject($product)
                    ) {
                        if ((int) $order_detail->id_customization === (int) $configurationCartDetail->id_customization) {
                            // TAX
                            self::saveTaxCalculator($order, $order_detail, $configurationCartDetail);

                            // Update order detail
                            if (isset($product->name[Context::getContext()->language->id])) {
                                $order_detail->product_name = $product->name[Context::getContext()->language->id];
                            }
                            $order_detail->original_product_price = $order_detail->unit_price_tax_excl;
                            $order_detail->product_price = $order_detail->unit_price_tax_excl;

                            // Update reference
                            $order_detail->product_reference = $configurationCartDetail->reference;

                            // CONFIGURATOR HOOK
                            Hook::exec('configuratorActionExtractFromOrderDetailHelper', [
                                'order_detail' => &$order_detail,
                                'configurationCartDetail' => $configurationCartDetail,
                                '',
                            ]);

                            $order_detail->save();

                            // Update id_order
                            $configurationCartDetail->id_order = (int) $order->id;
                            $configurationCartDetail->id_order_detail = (int) $order_detail->id;
                            $configurationCartDetail->save();
                        }
                    }
                }
            }
        }

        private static function saveTaxCalculator(Order $order, OrderDetail &$orderDetail, ConfiguratorCartDetailModel $configurationCartDetail)
        {
            // @TODO: usetax verification ?

            self::$orderDetails[] = $orderDetail->id;
            $taxes = $configurationCartDetail->getTaxesDetail();

            $values = '';
            foreach ($taxes as $tax) {
                $idOrderDetail = (int) $orderDetail->id;
                $idTax = self::getTaxFromTaxRulesGroup($order, (int) $tax['id_tax_rules_group']);
                $unitTaxAmount = (float) ($tax['price_tax_incl'] - $tax['price_tax_excl']);
                $totalTaxAmount = $unitTaxAmount * $orderDetail->product_quantity;

                $values .= '(' . $idOrderDetail . ',' . $idTax . ',' . $unitTaxAmount . ',' . $totalTaxAmount . '),';
            }
            $values = rtrim($values, ',');
            $sql = 'INSERT INTO `' . _DB_PREFIX_ . 'order_detail_tax` (id_order_detail, id_tax, unit_amount, total_amount)
                VALUES ' . $values;

            return Db::getInstance()->execute($sql);
        }

        private static function getTaxFromTaxRulesGroup($order, $id_tax_rules_group)
        {
            $invoiceAddress = new Address($order->id_address_invoice);
            $sql = 'SELECT * FROM `' . _DB_PREFIX_ . 'tax_rule` 
                WHERE `id_tax_rules_group` = ' . (int) $id_tax_rules_group . '
                AND `id_country` = ' . (int) $invoiceAddress->id_country;
            $result = Db::getInstance()->getRow($sql);

            return (int) $result['id_tax'];
        }

        /**
         * OrderDetail
         */
        private static function saveOrderDetail(
            Order $order,
            OrderDetail $order_detail,
            $insert,
            $product_name,
            Product $product,
            $configurationCartDetail,
            $customization
        ) {
            // Price
            $original_product_price = $configurationCartDetail->getPriceInCart($order->id_cart, false, 1, false);
            $unit_price_tax_excl = $configurationCartDetail->getPriceInCart($order->id_cart, true, $customization->quantity, false);
            $unit_price_tax_incl = $configurationCartDetail->getPriceInCart($order->id_cart, true, $customization->quantity, true);
            $total_price_tax_excl = $configurationCartDetail->getPriceInCart(
                $order->id_cart,
                true,
                $customization->quantity,
                false
            ) * $customization->quantity;
            $total_price_tax_incl = $configurationCartDetail->getPriceInCart(
                $order->id_cart,
                true,
                $customization->quantity,
                true
            ) * $customization->quantity;

            // Generate order detail
            $new_order_detail = ($insert) ? $order_detail->duplicateObject() : $order_detail;
            $new_order_detail->product_name = $product_name;
            $new_order_detail->product_weight = (float) ($product->weight + $configurationCartDetail->weight);
            $new_order_detail->product_quantity = (int) $customization->quantity;
            $new_order_detail->original_product_price = Tools::ps_round(
                $original_product_price,
                self::DECIMAL_PRECISION
            );
            $new_order_detail->product_price = Tools::ps_round($original_product_price, self::DECIMAL_PRECISION);
            $new_order_detail->unit_price_tax_excl = Tools::ps_round($unit_price_tax_excl, self::DECIMAL_PRECISION);
            $new_order_detail->unit_price_tax_incl = Tools::ps_round($unit_price_tax_incl, self::DECIMAL_PRECISION);
            $new_order_detail->total_price_tax_excl = Tools::ps_round($total_price_tax_excl, self::DECIMAL_PRECISION);
            $new_order_detail->total_price_tax_incl = Tools::ps_round($total_price_tax_incl, self::DECIMAL_PRECISION);

            // Update reference
            $new_order_detail->product_reference = $configurationCartDetail->reference;

            /*
             * @deprecated: #CONFIGURAT-266
             */
            if (Validate::isLoadedObject(self::$tax)) {
                $new_order_detail->tax_name = isset(self::$tax->name[Context::getContext()->language->id])
                    ? self::$tax->name[Context::getContext()->language->id]
                    : '';
                $new_order_detail->tax_rate = self::$tax->rate;
            }

            // CONFIGURATOR HOOK
            Hook::exec('configuratorActionExtractFromOrderDetailHelper', [
                'order_detail' => &$new_order_detail,
                'configurationCartDetail' => $configurationCartDetail,
            ]);

            // Save order detail
            $new_order_detail->save();

            // Save order detail tax
            self::saveOrderDetailTax($new_order_detail, (bool) $insert);

            return $new_order_detail;
        }

        /**
         * OrderDetailTax
         */
        public static function saveOrderDetailTax($new_order_detail, $insert = true)
        {
            $orderDetailTaxArray = [
                'id_tax' => Validate::isLoadedObject(self::$tax) ? self::$tax->id : 0,
                'unit_amount' => $new_order_detail->unit_price_tax_incl - $new_order_detail->unit_price_tax_excl,
                'total_amount' => $new_order_detail->total_price_tax_incl - $new_order_detail->total_price_tax_excl,
            ];
            if ($insert) { // Update Tax
                self::insertOrderDetailTax($orderDetailTaxArray, $new_order_detail);
            } else { // Insert Tax
                self::updateOrderDetailTax($orderDetailTaxArray, $new_order_detail);
            }
        }

        private static function insertOrderDetailTax($orderDetailTaxArray, $new_order_detail)
        {
            $orderDetailTaxArray['id_order_detail'] = (int) $new_order_detail->id;
            $values = '\'' . implode('\',\'', $orderDetailTaxArray) . '\'';
            $fields = implode(',', array_keys($orderDetailTaxArray));
            $sql_order_detail_tax = 'INSERT INTO `' . _DB_PREFIX_ . 'order_detail_tax` (' . $fields . ')';
            $sql_order_detail_tax .= ' VALUES(' . $values . ')';
            Db::getInstance()->execute($sql_order_detail_tax);
        }

        private static function updateOrderDetailTax($orderDetailTaxArray, $new_order_detail)
        {
            $sql_order_detail_tax = 'UPDATE `' . _DB_PREFIX_ . 'order_detail_tax` SET ';
            $i = 0;
            foreach ($orderDetailTaxArray as $field => $value) {
                $sql_order_detail_tax .= (($i) ? ', ' : '') . $field . ' = \'' . $value . '\'';
                ++$i;
            }
            $sql_order_detail_tax .= 'WHERE `id_order_detail` = ' . (int) $new_order_detail->id;
            Db::getInstance()->execute($sql_order_detail_tax);
        }

        private static function initTaxByIdOrderDetail($idOrderDetail)
        {
            $sql = [
                'SELECT tr.id_tax',
                'FROM ' . _DB_PREFIX_ . 'order_detail od',
                'LEFT JOIN ' . _DB_PREFIX_ . 'orders o ON od.id_order = o.id_order',
                'LEFT JOIN ' . _DB_PREFIX_ . 'address a ON o.id_address_invoice = a.id_address',
                'LEFT JOIN ' . _DB_PREFIX_ . 'tax_rule tr ON (tr.id_tax_rules_group = od.id_tax_rules_group AND tr.id_country = a.id_country)',
                'WHERE od.id_order_detail = ' . (int) $idOrderDetail,
            ];
            $result = Db::getInstance()->executeS(implode(' ', $sql));

            if (isset($result[0]['id_tax'])) {
                $idTax = (int) $result[0]['id_tax'];
                self::$tax = new Tax($idTax);
            }
            self::$tax = null;
        }
    }
}
