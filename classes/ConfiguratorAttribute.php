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

if (!class_exists('ConfiguratorAttribute')) {
    require_once dirname(__FILE__) . '/ConfiguratorBridgeAttribute.php';

    /**
     * Class configuratorCartDetailModel
     * Override AttributeCore of Prestashop
     * We define new properties use in the module
     */
    class ConfiguratorAttribute extends ConfiguratorBridgeAttribute
    {
        public $texture_image = 0;
        public $ref_ral = '';

        public function __construct($id = null, $id_lang = null, $id_shop = null)
        {
            self::$definition['fields']['texture_image'] = [
                'type' => self::TYPE_BOOL,
                'validate' => 'isBool',
            ];

            self::$definition['fields']['ref_ral'] = [
                'type' => self::TYPE_STRING,
            ];

            parent::__construct($id, $id_lang, $id_shop);
        }

        /**
         * Get Attribute by name
         *
         * @param string $name
         * @param string $id_lang
         *
         * @return ConfiguratorBridgeAttribute
         */
        public static function getAttributeByName($name, $id_lang)
        {
            $sql = 'SELECT * '
                . 'FROM `' . _DB_PREFIX_ . 'attribute_lang` '
                . "WHERE `name` = '" . pSQL($name) . "' "
                . 'AND `id_lang` = ' . (int) $id_lang;
            $return = Db::getInstance()->getRow($sql);

            if ($return !== false && $return['id_attribute'] !== '') {
                $id_attribute = (int) $return['id_attribute'];

                return new ConfiguratorBridgeAttribute($id_attribute);
            }

            return new ConfiguratorBridgeAttribute();
        }

        public static function getColorByIdOption($id_option)
        {
            $sql = 'SELECT color '
                   . 'FROM `' . _DB_PREFIX_ . 'attribute` '
                   . "WHERE `id_attribute` = '" . (int) $id_option . "' ";

            if ($result = Db::getInstance()->getRow($sql)) {
                return $result['color'];
            }

            return '';
        }
    }
}
