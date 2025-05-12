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

class PaymentModule extends PaymentModuleCore
{
    protected function getEmailTemplateContent($template_name, $mail_type, $var)
    {
        $var = $this->overrideConfigurator();
        $email_configuration = Configuration::get('PS_MAIL_TYPE');
        if ($email_configuration != $mail_type && $email_configuration != Mail::TYPE_BOTH) {
            return '';
        }

        $theme_template_path = _PS_THEME_DIR_ . 'mails' . DIRECTORY_SEPARATOR
            . $this->context->language->iso_code . DIRECTORY_SEPARATOR . $template_name;
        $default_mail_template_path = _PS_MAIL_DIR_ . $this->context->language->iso_code
            . DIRECTORY_SEPARATOR . $template_name;

        if (Tools::file_exists_cache($theme_template_path)) {
            $default_mail_template_path = $theme_template_path;
        }

        if (Tools::file_exists_cache($default_mail_template_path)) {
            $this->context->smarty->assign('list', $var);

            return $this->context->smarty->fetch($default_mail_template_path);
        }

        return '';
    }

    public function overrideConfigurator()
    {
        require_once dirname(__FILE__) . '/../../modules/configurator/classes/ConfiguratorCartDetailModel.php';

        $context = Context::getContext();
        $cart = $context->cart;
        $order = new Order((int) Order::getOrderByCartId($cart->id));

        $product_var_tpl_list = [];
        if (Validate::isLoadedObject($order)) {
            foreach ($order->getProducts() as $product) {
                $product_var_tpl = [
                    'reference' => $product['reference'],
                    'name' => $product['product_name'],
                    'unit_price' => Tools::displayPrice($product['unit_price_tax_incl'], $context->currency, false),
                    'price' => Tools::displayPrice($product['total_price_tax_incl'], $context->currency, false),
                    'quantity' => (int) $product['product_quantity'],
                    'customization' => [],
                ];
                $customized_datas = Product::getAllCustomizedDatas((int) $order->id_cart);
                if (isset($customized_datas[$product['product_id']][$product['product_attribute_id']])) {
                    $customized_product = $customized_datas[$product['product_id']][$product['product_attribute_id']];
                    foreach ($customized_product[$order->id_address_delivery] as $customization) {
                        $customization_text = '';
                        if (isset($customization['datas'][Product::CUSTOMIZE_TEXTFIELD])) {
                            foreach ($customization['datas'][Product::CUSTOMIZE_TEXTFIELD] as $text) {
                                $customization_text .= $text['name'] . ': ' . $text['value'] . '<br />';
                            }
                        }

                        if (isset($customization['datas'][Product::CUSTOMIZE_FILE])) {
                            $customization_text .= sprintf(
                                Tools::displayError('%d image(s)'),
                                count($customization['datas'][Product::CUSTOMIZE_FILE])
                            ) . '<br />';
                        }

                        $customization_quantity = (int) $product['product_quantity'];

                        $product_var_tpl['customization'][] = [
                            'customization_text' => $customization_text,
                            'customization_quantity' => $customization_quantity,
                            'quantity' => Tools::displayPrice(
                                $customization_quantity * $product['unit_price_tax_incl'],
                                $this->context->currency,
                                false
                            ),
                        ];
                    }
                }
                $product_var_tpl_list[] = $product_var_tpl;
            }
        }

        return $product_var_tpl_list;
    }
}
