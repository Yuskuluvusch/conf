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

require_once dirname(__FILE__) . '/../DmCache.php';
if (!defined('_CAN_LOAD_FILES_')) {
    exit;
}

if (!class_exists('ConfiguratorStepDisplayConditionModel')) {
    /**
     * Class configuratorStepDisplayConditionModel
     */
    class ConfiguratorStepDisplayConditionModel extends ObjectModel
    {
        public $id_configurator_step_display_condition_group;
        public $value;
        public $min;
        public $max;
        public $formula;
        public static $definition = [
            'table' => 'configurator_step_display_condition',
            'primary' => 'id_configurator_step_display_condition',
            'fields' => [
                /* Classic fields */
                'id_configurator_step_display_condition_group' => [
                    'type' => self::TYPE_INT,
                    'validate' => 'isUnsignedId',
                    'required' => true,
                ],
                'value' => ['type' => self::TYPE_INT, 'validate' => 'isUnsignedId', 'required' => true],
                'min' => ['type' => self::TYPE_FLOAT],
                'max' => ['type' => self::TYPE_FLOAT],
                'formula' => ['type' => self::TYPE_STRING],
            ],
        ];

        public function duplicate($id_condition_group, $new_value)
        {
            if (!$new_value) {
                return false;
            }

            $new_condition = $this->duplicateObject();
            if (!Validate::isLoadedObject($new_condition)) {
                return false;
            }

            $new_condition->id_configurator_step_display_condition_group = (int) $id_condition_group;
            $new_condition->value = (int) $new_value;

            if (!$new_condition->save()) {
                return false;
            }

            return (int) $new_condition->id;
        }

        public static function getConditions($group_id)
        {
            $key = 'configurator::getConditions' . $group_id;
            if (DmCache::getInstance()->isStored($key)) {
                $conditions = DmCache::getInstance()->retrieve($key);
            } else {
                $sql = 'SELECT * FROM `' . _DB_PREFIX_ . self::$definition['table'] . '` csdc';
                $sql .= ' WHERE csdc.id_configurator_step_display_condition_group=' . (int) $group_id;
                $result = Db::getInstance()->executeS($sql);
                $condition = new ConfiguratorStepDisplayConditionGroupModel();
                $conditions = [];
                if (!empty($result)) {
                    $conditions = $condition->hydrateCollection(get_class(), $result);
                }

                DmCache::getInstance()->store($key, $conditions);
            }

            /*
             * @todo: Revoir encore une fois cette fonction
             *
             * $key = 'configuratorstepconditionmodel::getConditions-'.$group_id;
             * if (Cache::isStored($key)) {
             * return DmCache::getInstance()->retrieve($key);
             * }
             *
             * $key = 'configuratorstepconditionmodel::getConditions';
             * if (Cache::isStored($key)) {
             * $result_conditions = DmCache::getInstance()->retrieve($key);
             * } else {
             * $sql = 'SELECT * FROM `'._DB_PREFIX_.self::$definition['table'].'` csdc ';
             * //. 'WHERE csdc.id_configurator_step_display_condition_group='.(int)$group_id;
             * $results = Db::getInstance()->executeS($sql);
             *
             * $result_conditions = array();
             * foreach ($results as $result) {
             * $result_conditions[$result['id_configurator_step_display_condition_group']] = $result;
             * }
             * DmCache::getInstance()->store($key, $result_conditions);
             * }
             *
             * $key = 'configuratorstepconditionmodel::getConditions-'.$group_id;
             * if (!Cache::isStored($key)) {
             * $condition = new ConfiguratorStepDisplayConditionGroupModel();
             * $conditions = array();
             * if (!empty($result_conditions)) {
             * $conditions = $condition->hydrateCollection(get_class(), array(0 =>$result_conditions[$group_id]));
             * }
             * DmCache::getInstance()->store($key, $conditions);
             * }*/

            return $conditions;
        }

        public static function deleteByValue($value)
        {
            $conditions = self::getConditionsByValue($value);
            foreach ($conditions as $condition) {
                $condition->delete();
            }
        }

        public static function getConditionsByValue($value)
        {
            $key = 'configurator::getConditionsByValue' . $value;
            if (DmCache::getInstance()->isStored($key)) {
                $conditions = DmCache::getInstance()->retrieve($key);
            } else {
                $sql = 'SELECT * FROM `' . _DB_PREFIX_ . self::$definition['table'] . '` csdc';
                $sql .= ' WHERE csdc.value=' . (int) $value;
                $result = Db::getInstance()->executeS($sql);
                $condition = new ConfiguratorStepDisplayConditionGroupModel();
                $conditions = [];
                if (!empty($result)) {
                    $conditions = $condition->hydrateCollection(get_class(), $result);
                }

                DmCache::getInstance()->store($key, $conditions);
            }

            return $conditions;
        }

        public function getType()
        {
            if (!$this->formula && (int) $this->value > 0) {
                return 'option';
            } else {
                return 'formula';
            }
        }
    }
}
