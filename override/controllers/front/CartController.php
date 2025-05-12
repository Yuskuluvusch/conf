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

class CartController extends CartControllerCore
{
    protected function updateCart()
    {
        parent::updateCart();

        if ((int) Tools::getValue('configurator') === 1) {
            Tools::redirectLink($this->context->link->getPageLink(
                'cart',
                true,
                null,
                'action=show&token=' . Tools::getToken(false),
                false
            ));
        }
    }

    protected function processDeleteProductInCart()
    {
        // FIX : le configurateur créer les "customization" lorsqu'on on personnalise un produit
        // (avant même qu'il soit dans le panier avec le champ "in_cart" à 0)
        // Si on essaye de supprimer un produit du panier et qu'il existe des customization
        // avec le champs "in_cart" à 0, PS les prend quand même en compte et plante

        $add_id = 1000000000;

        Db::getInstance()->execute(
            'UPDATE `' . _DB_PREFIX_ . 'customization`'
            . ' SET `id_cart` = ' . (int) ($this->context->cart->id + $add_id)
            . ', `id_product` = ' . (int) ($this->id_product + $add_id)
            . ' WHERE `id_cart` = ' . (int) $this->context->cart->id
            . ' AND `id_product` = ' . (int) $this->id_product
            . ' AND `id_customization` != ' . (int) $this->customization_id
            . ' AND in_cart = 0'
        );

        parent::processDeleteProductInCart();

        Db::getInstance()->execute(
            'UPDATE `' . _DB_PREFIX_ . 'customization`'
            . ' SET `id_cart` = ' . (int) $this->context->cart->id
            . ', `id_product` = ' . (int) $this->id_product
            . ' WHERE `id_cart` = ' . (int) ($this->context->cart->id + $add_id)
            . ' AND `id_product` = ' . (int) ($this->id_product + $add_id)
            . ' AND `id_customization` != ' . (int) $this->customization_id
            . ' AND in_cart = 0'
        );
    }
}
