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

class Product extends ProductCore
{
    private static function manageCustomizationId($method, $id_customization_tmp = null)
    {
        static $id_customization;
        if ($method == 'get') {
            return (int) $id_customization;
        } else {
            if ($method == 'set') {
                $id_customization = $id_customization_tmp;
            }
        }
    }

    public static function setCustomizationId($id_customization)
    {
        self::manageCustomizationId('set', $id_customization);
    }

    public static function getCustomizationId()
    {
        return self::manageCustomizationId('get');
    }

    public static function isConfigurated($idProduct, $useCombination = false)
    {
        require_once dirname(__FILE__) . '/../../modules/configurator/classes/ConfiguratorModel.php';
        $configurator = ConfiguratorModel::getByIdProduct((int) $idProduct, true, true);
        if (Validate::isLoadedObject($configurator)) {
            if (!$useCombination || $configurator->use_combination) {
                return $configurator;
            }
        }

        return false;
    }

    public function deleteConfigurator()
    {
        if (Configuration::get('PS_ADVANCED_STOCK_MANAGEMENT') && $this->advanced_stock_management) {
            $stock_manager = StockManagerFactory::getManager();
            $physical_quantity = $stock_manager->getProductPhysicalQuantities($this->id, 0);
            $real_quantity = $stock_manager->getProductRealQuantities($this->id, 0);
            if ($physical_quantity > 0) {
                return false;
            }
            if ($real_quantity > $physical_quantity) {
                return false;
            }

            $warehouse_product_locations = Adapter_ServiceLocator::get('Core_Foundation_Database_EntityManager')
                ->getRepository('WarehouseProductLocation')
                ->findByIdProduct($this->id);
            foreach ($warehouse_product_locations as $warehouse_product_location) {
                $warehouse_product_location->delete();
            }

            $stocks = Adapter_ServiceLocator::get('Core_Foundation_Database_EntityManager')
                ->getRepository('Stock')
                ->findByIdProduct($this->id);
            foreach ($stocks as $stock) {
                $stock->delete();
            }
        }
        $result = ObjectModel::delete();

        // Removes the product from StockAvailable, for the current shop
        StockAvailable::removeProductFromStockAvailable($this->id);
        $result &= ($this->deleteProductAttributes() && $this->deleteImages() && $this->deleteSceneProducts());
        // If there are still entries in product_shop, don't remove completely the product
        if ($this->hasMultishopEntries()) {
            return true;
        }

        Hook::exec('actionProductDelete', ['id_product' => (int) $this->id, 'product' => $this]);
        if (
            !$result
            || !GroupReduction::deleteProductReduction($this->id)
            || !$this->deleteCategories(false) || !$this->deleteProductFeatures()
            || !$this->deleteTags()
            || !$this->deleteCartProducts()
            || !$this->deleteAttributesImpacts()
            || !$this->deleteAttachments(false)
            || !$this->deleteCustomization()
            || !SpecificPrice::deleteByProductId((int) $this->id)
            || !$this->deletePack()
            || !$this->deleteProductSale()
            || !$this->deleteSearchIndexes()
            || !$this->deleteAccessories()
            || !$this->deleteFromAccessories()
            || !$this->deleteFromSupplier()
            || !$this->deleteDownload()
            || !$this->deleteFromCartRules()
        ) {
            return false;
        }

        return true;
    }

    public static function addCustomizationPrice(&$products, &$customized_datas)
    {
        if (!$customized_datas) {
            return;
        }

        foreach ($products as &$product_update) {
            if (!Customization::isFeatureActive()) {
                $product_update['customizationQuantityTotal'] = 0;
                $product_update['customizationQuantityRefunded'] = 0;
                $product_update['customizationQuantityReturned'] = 0;
            } else {
                $customization_quantity = 0;
                $customization_quantity_refunded = 0;
                $customization_quantity_returned = 0;

                $product_id = isset($product_update['id_product']) ? (int) $product_update['id_product'] : (int) $product_update['product_id'];
                $product_attribute_id = isset($product_update['id_product_attribute']) ? (int) $product_update['id_product_attribute'] : (int) $product_update['product_attribute_id'];
                $id_address_delivery = (int) $product_update['id_address_delivery'];
                $product_quantity = isset($product_update['cart_quantity']) ? (int) $product_update['cart_quantity'] : (int) $product_update['product_quantity'];

                if (!isset($customized_datas[$product_id][$product_attribute_id][$id_address_delivery])) {
                    $id_address_delivery = 0;
                }
                if (isset($customized_datas[$product_id][$product_attribute_id][$id_address_delivery])) {
                    foreach ($customized_datas[$product_id][$product_attribute_id][$id_address_delivery] as $customization) {
                        if ((int) $product_update['id_customization'] && $customization['id_customization'] != $product_update['id_customization']) {
                            continue;
                        }
                        $customization_quantity += (int) $customization['quantity'];
                        $customization_quantity_refunded += (int) $customization['quantity_refunded'];
                        $customization_quantity_returned += (int) $customization['quantity_returned'];
                    }
                }

                $product_update['customizationQuantityTotal'] = $customization_quantity;
                $product_update['customizationQuantityRefunded'] = $customization_quantity_refunded;
                $product_update['customizationQuantityReturned'] = $customization_quantity_returned;

                if ($customization_quantity) {
                    $product_update['total_wt'] = $product_update['unit_price_tax_incl'] * $product_quantity;
                    $product_update['total_customization_wt'] = $product_update['unit_price_tax_incl'] * $customization_quantity;
                    $product_update['total'] = $product_update['unit_price_tax_excl'] * $product_quantity;
                    $product_update['total_customization'] = $product_update['unit_price_tax_excl'] * $customization_quantity;
                }
            }
        }
    }

    public static function addProductCustomizationPrice(&$product, &$customized_datas)
    {
        if (!$customized_datas) {
            return;
        }

        $products = [$product];
        self::addCustomizationPrice($products, $customized_datas);
        $product = $products[0];
    }
}
