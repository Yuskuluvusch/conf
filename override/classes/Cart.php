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

class Cart extends CartCore
{
    public function duplicate()
    {
        $return = parent::duplicate();

        // Valid in Prestashop 1.6 version
        $cart = isset($return['cart']) ? $return['cart'] : false;

        if (Tools::getValue('submitReorder') === ''
            && Tools::getValue('id_order')
            && Validate::isLoadedObject($cart)
        ) {
            require_once dirname(__FILE__) . '/../../modules/configurator/classes/OrderDetailHelper.php';

            OrderDetailHelper::duplicateCart($cart, Tools::getValue('id_order'));
        }

        return $return;
    }

    public function updateQty(
        $quantity,
        $id_product,
        $id_product_attribute = null,
        $id_customization = false,
        $operator = 'up',
        $id_address_delivery = 0,
        $shop = null,
        $auto_add_cart_rule = true,
        $skipAvailabilityCheckOutOfStock = false,
        bool $preserveGiftRemoval = true,
        bool $useOrderPrices = false
    ) {
        if (Module::isInstalled('AdvancedQuote')) {
            if (Tools::getIsset('id_advancedquote')) {
                require_once dirname(__FILE__) . '/../../modules/advancedquote/classes/AdvancedquoteModel.php';
                $advancedquote = new AdvancedquoteModel((int) Tools::getValue('id_advancedquote'));
                Context::getContext()->cart = new Cart((int) $advancedquote->id_cart);
            }
        }

        require_once dirname(__FILE__) . '/../../modules/configurator/classes/ConfiguratorModel.php';
        if (!$id_customization) {
            $configurator = ConfiguratorModel::getByIdProduct($id_product);

            if (Validate::isLoadedObject($configurator)) {
                require_once dirname(__FILE__) . '/../../modules/configurator/classes/ConfiguratorCartDetailModel.php';
                $configuratorCartDetail = new ConfiguratorCartDetailModel();
                $configuratorCartDetail->id_configurator = (int) $configurator->id;
                $configuratorCartDetail->id_cart = (int) Context::getContext()->cart->id;
                $configuratorCartDetail->id_product = (int) $id_product;
                $configuratorCartDetail->id_product_attribute = (int) $id_product_attribute;
                $configuratorCartDetail->product = new Product((int) $id_product); // $this->configurator_product;
                $configuratorCartDetail->setDetail([]);
                $configuratorCartDetail->setCustomization();
                $configuratorCartDetail->setCustomization();
                $configuratorCartDetail->added_in_cart = true;
                $configuratorCartDetail->save();

                $id_customization = $configuratorCartDetail->id_customization;
            }
        }

        $result = parent::updateQty(
            $quantity,
            $id_product,
            $id_product_attribute,
            $id_customization,
            $operator,
            $id_address_delivery,
            $shop,
            $auto_add_cart_rule,
            $skipAvailabilityCheckOutOfStock
        );

        if ($result && Configuration::get('CONFIGURATOR_REDIRECT_AFTER_CART')) {
            $configurator = ConfiguratorModel::getByIdProduct($id_product, true);
            if (Validate::isLoadedObject($configurator)) {
                Context::getContext()->cookie->__set('display_modal_added_in_cart', true);
                Context::getContext()->cookie->__set('display_modal_added_in_cart_customization', $id_customization);
                Tools::redirectLink(Context::getContext()->link->getProductLink($id_product));
            }
        }

        return $result;
    }

    public function deleteWithoutCustomizedData()
    {
        if ($this->orderExists()) { // NOT delete a cart which is associated with an order
            return false;
        }

        $uploaded_files = Db::getInstance()->executeS(
            'SELECT cd.`value`
            FROM `' . _DB_PREFIX_ . 'customized_data` cd
            INNER JOIN `' . _DB_PREFIX_ . 'customization` c ON (cd.`id_customization`= c.`id_customization`)
            WHERE cd.`type`= ' . (int) Product::CUSTOMIZE_FILE . ' AND c.`id_cart`=' . (int) $this->id
        );

        foreach ($uploaded_files as $must_unlink) {
            unlink(_PS_UPLOAD_DIR_ . $must_unlink['value'] . '_small');
            unlink(_PS_UPLOAD_DIR_ . $must_unlink['value']);
        }

        Db::getInstance()->execute(
            'DELETE FROM `' . _DB_PREFIX_ . 'customization`
            WHERE `id_cart` = ' . (int) $this->id
        );

        if (!Db::getInstance()->execute('DELETE FROM `' . _DB_PREFIX_ . 'cart_cart_rule` WHERE `id_cart` = ' . (int) $this->id)
            || !Db::getInstance()->execute('DELETE FROM `' . _DB_PREFIX_ . 'cart_product` WHERE `id_cart` = ' . (int) $this->id)) {
            return false;
        }

        // @hook actionObject*DeleteBefore
        Hook::exec('actionObjectDeleteBefore', ['object' => $this]);
        Hook::exec('actionObjectCartDeleteBefore', ['object' => $this]);

        $this->clearCache();
        $result = true;
        // Remove association to multishop table
        if (Shop::isTableAssociated($this->def['table'])) {
            $id_shop_list = Shop::getContextListShopID();
            if (count($this->id_shop_list)) {
                $id_shop_list = $this->id_shop_list;
            }

            $id_shop_list = array_map('intval', $id_shop_list);

            $result &= Db::getInstance()->delete($this->def['table'] . '_shop', '`' . $this->def['primary'] . '`=' .
                (int) $this->id . ' AND id_shop IN (' . implode(', ', $id_shop_list) . ')');
        }

        // Database deletion
        $has_multishop_entries = $this->hasMultishopEntries();

        // Database deletion for multilingual fields related to the object
        if (!empty($this->def['multilang']) && !$has_multishop_entries) {
            $result &= Db::getInstance()->delete($this->def['table'] . '_lang', '`' . bqSQL($this->def['primary']) . '` = ' . (int) $this->id);
        }

        if ($result && !$has_multishop_entries) {
            $result &= Db::getInstance()->delete($this->def['table'], '`' . bqSQL($this->def['primary']) . '` = ' . (int) $this->id);
        }

        if (!$result) {
            return false;
        }

        // @hook actionObject*DeleteAfter
        Hook::exec('actionObjectDeleteAfter', ['object' => $this]);
        Hook::exec('actionObjectCartDeleteAfter', ['object' => $this]);

        return $result;
    }
}
