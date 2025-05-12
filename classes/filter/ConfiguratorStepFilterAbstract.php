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

require_once dirname(__FILE__) . '/ConfiguratorStepFilterFactory.php';
require_once dirname(__FILE__) . '/../../DmCache.php';

/**
 * Class ConfiguratorStepFilterAbstract
 */
abstract class ConfiguratorStepFilterAbstract extends ObjectModel
{
    // Filter types
    public const TYPE_FILTER_FEATURES = 'features';

    public const TYPE_FILTER_ATTRIBUTES = 'attributes';

    // Value types
    public const TYPE_VALUE_ID = 'id';
    public const TYPE_VALUE_NAME = 'name';

    // Operator types
    public const TYPE_OPERATOR_EQUAL = 'EQUAL'; // '=';
    public const TYPE_OPERATOR_CONTAINS = 'CONTAINS'; // '%LIKE%';
    public const TYPE_OPERATOR_CONTAINS_AT_LEAST = 'CONTAINS_ONE';
    public const TYPE_OPERATOR_CONTAINED = 'CONTAINED'; // '%CONTAINED%';
    public const TYPE_OPERATOR_UPPER = 'UPPER'; // '>';
    public const TYPE_OPERATOR_UPPER_OR_EQUAL = 'UPPER_OR_EQUAL'; // '>=';
    public const TYPE_OPERATOR_LOWER = 'LOWER'; // '<';
    public const TYPE_OPERATOR_LOWER_OR_EQUAL = 'LOWER_OR_EQUAL'; // '<=';
    public const TYPE_OPERATOR_EQUAL_NUMBER = 'EQUAL_NUMBER'; // '=NUMBER';
    public const TYPE_OPERATOR_UPPER_NUMBER = 'UPPER_NUMBER'; // '>NUMBER';
    public const TYPE_OPERATOR_UPPER_OR_EQUAL_NUMBER = 'UPPER_OR_EQUAL_NUMBER'; // '>=NUMBER';
    public const TYPE_OPERATOR_LOWER_NUMBER = 'LOWER_NUMBER'; // '<NUMBER';
    public const TYPE_OPERATOR_LOWER_OR_EQUAL_NUMBER = 'LOWER_OR_EQUAL_NUMBER'; // '<=NUMBER';
    public const TYPE_OPERATOR_EQUAL_FORMULA = 'EQUAL_FORMULA'; // '=FORMULA';
    public const TYPE_OPERATOR_UPPER_FORMULA = 'UPPER_FORMULA'; // '>FORMULA';
    public const TYPE_OPERATOR_UPPER_OR_EQUAL_FORMULA = 'UPPER_OR_EQUAL_FORMULA'; // '>=FORMULA';
    public const TYPE_OPERATOR_LOWER_FORMULA = 'LOWER_FORMULA'; // '<FORMULA';
    public const TYPE_OPERATOR_LOWER_OR_EQUAL_FORMULA = 'LOWER_OR_EQUAL_FORMULA'; // '<=FORMULA';

    public $id_configurator_step_filter_group;
    public $type = self::TYPE_FILTER_FEATURES;
    public $id_option;
    public $operator;
    public $id_target_step;
    public $target_type = self::TYPE_FILTER_FEATURES;
    public $id_target_option;
    public $type_value = self::TYPE_VALUE_ID;
    public $formula;

    protected static $formula_result_cache = [];

    public static $definition = [
        'table' => 'configurator_step_filter',
        'primary' => 'id_configurator_step_filter',
        'fields' => [
            /* Classic fields */
            'id_configurator_step_filter_group' => [
                'type' => self::TYPE_INT,
                'validate' => 'isUnsignedId',
                'required' => true,
            ],
            'type' => ['type' => self::TYPE_STRING, 'validate' => 'isString', 'required' => true],
            'id_option' => ['type' => self::TYPE_INT, 'validate' => 'isUnsignedId'],
            'operator' => ['type' => self::TYPE_STRING, 'validate' => 'isString', 'required' => true],
            'id_target_step' => ['type' => self::TYPE_INT, 'validate' => 'isUnsignedId'],
            'target_type' => ['type' => self::TYPE_STRING, 'validate' => 'isString', 'required' => true],
            'id_target_option' => ['type' => self::TYPE_INT, 'validate' => 'isUnsignedId'],
            'type_value' => ['type' => self::TYPE_STRING, 'validate' => 'isString', 'required' => true],
            'formula' => ['type' => self::TYPE_STRING, 'validate' => 'isString'],
        ],
    ];

    public function __construct($id = null, $id_lang = null, $id_shop = null)
    {
        parent::__construct($id, $id_lang, $id_shop);
    }

    abstract public function getOption($lang_id);

    abstract public function isValid($id_configurator_step_option, $cart_detail);

    public static function getFilters($group_id = 0)
    {
        $key = 'ConfiguratorStepFilterAbstract::getFilters' . (int) $group_id;
        if (DmCache::getInstance()->isStored($key)) {
            $filters = DmCache::getInstance()->retrieve($key);
        } else {
            $sql = 'SELECT * FROM `' . _DB_PREFIX_ . self::$definition['table'] . '` csf';
            if ((int) $group_id > 0) {
                $sql .= ' WHERE csf.id_configurator_step_filter_group=' . (int) $group_id;
            }
            $result = Db::getInstance()->executeS($sql);
            $filters = ConfiguratorStepFilterFactory::hydrateCollection($result);
            DmCache::getInstance()->store($key, $filters);
        }

        return $filters;
    }
}
