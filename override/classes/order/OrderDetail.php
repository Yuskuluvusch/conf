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

class OrderDetail extends OrderDetailCore
{
    public function __construct($id = null, $id_lang = null, $context = null)
    {
        self::$definition['fields']['product_name'] = [
            'type' => self::TYPE_HTML,
            'validate' => 'isCleanHtml',
            'required' => true,
        ];

        parent::__construct($id, $id_lang, $context);
    }

    public function saveTaxCalculator(Order $order, $replace = false)
    {
        require_once dirname(__FILE__) . '/../../../modules/configurator/classes/OrderDetailHelper.php';
        if (is_array(OrderDetailHelper::$orderDetails) && in_array($this->id, OrderDetailHelper::$orderDetails)) {
            return true;
        }
        parent::saveTaxCalculator($order, $replace);
    }
}
