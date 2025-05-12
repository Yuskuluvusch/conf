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

if (!class_exists('ConfiguratorStepFilterGroupModel')) {
    require_once dirname(__FILE__) . '/ConfiguratorStepFilterTypeAttributeModel.php';
    require_once dirname(__FILE__) . '/ConfiguratorStepFilterTypeFeatureModel.php';
    require_once dirname(__FILE__) . '/../../DmCache.php';

    /**
     * Class ConfiguratorStepFilterGroupModel
     */
    class ConfiguratorStepFilterGroupModel extends ObjectModel
    {
        private static $_type_filters = [
            'step' => 'id_configurator_step',
            'option' => 'id_configurator_step_option',
        ];
        public $id_configurator_step;
        public $id_configurator_step_option;

        /**
         * Filters collection
         */
        public $filters = [];
        public static $definition = [
            'table' => 'configurator_step_filter_group',
            'primary' => 'id_configurator_step_filter_group',
            'fields' => [
                /* Classic fields */
                'id_configurator_step' => ['type' => self::TYPE_INT, 'validate' => 'isUnsignedId'],
                'id_configurator_step_option' => ['type' => self::TYPE_INT, 'validate' => 'isUnsignedId'],
            ],
        ];

        public function delete()
        {
            $result = parent::delete();
            if ($result) {
                $filters = ConfiguratorStepFilterAbstract::getFilters((int) $this->id);
                foreach ($filters as $filter) {
                    $filter->delete();
                }
            }

            return $result;
        }

        public function duplicate($type, $foreignkey)
        {
            $field = self::$_type_filters[$type];
            $new_filter_group = $this->duplicateObject();
            if (!Validate::isLoadedObject($new_filter_group)) {
                return false;
            }

            $new_filter_group->{$field} = (int) $foreignkey;
            if (!$new_filter_group->save()) {
                return false;
            }

            return (int) $new_filter_group->id;
        }

        public static function deleteFilters($type, $foreignkey)
        {
            $groups = self::getFilterGroups($type, $foreignkey);
            foreach ($groups as $group) {
                $group->delete();
            }
            Configurator::cleanCache();
        }

        public static function getFilterGroups($type, $foreignkey)
        {
            $key = 'configurator::getFilterGroups' . $type . '-' . $foreignkey;
            if (DmCache::getInstance()->isStored($key)) {
                $groups = DmCache::getInstance()->retrieve($key);
            } else {
                $field = self::$_type_filters[$type];
                $sql = 'SELECT * FROM `' . _DB_PREFIX_ . self::$definition['table'] . '` csfg';
                $sql .= ' WHERE csfg.`' . $field . '`=' . (int) $foreignkey;
                $result = Db::getInstance()->executeS($sql);
                $group = new ConfiguratorStepFilterGroupModel();
                $groups = [];
                if (!empty($result)) {
                    $groups = $group->hydrateCollection(get_class(), $result);
                }
                DmCache::getInstance()->store($key, $groups);
            }

            return $groups;
        }

        public static function getFilters($type, $foreignkey)
        {
            $key = 'configuratorstepdisplayfilter-getFilters-' . $type . '-' . $foreignkey;
            if (DmCache::getInstance()->isStored($key)) {
                $groups = DmCache::getInstance()->retrieve($key);
            } else {
                $groups = self::getFilterGroups($type, $foreignkey);
                if (!$groups && $type === ConfiguratorStepAbstract::TYPE_CONDITION_OPTION) {
                    $option = ConfiguratorStepOptionFactory::newObject($foreignkey);
                    if ($option) {
                        $groups = self::getFilterGroups(
                            ConfiguratorStepAbstract::TYPE_CONDITION_STEP,
                            $option->id_configurator_step
                        );
                    }
                }
                foreach ($groups as &$group) {
                    $group->filters = ConfiguratorStepFilterAbstract::getFilters((int) $group->id);
                }
                DmCache::getInstance()->store($key, $groups);
            }

            return $groups;
        }

        public static function saveFilters($type, $foreignkey, $filter_groups)
        {
            if ($foreignkey && isset(self::$_type_filters[$type])) {
                $field = self::$_type_filters[$type];

                foreach ($filter_groups as $filter_group) {
                    $group = new ConfiguratorStepFilterGroupModel();
                    $group->{$field} = (int) $foreignkey;
                    if (isset($filter_group['datas']) && $group->save()) {
                        foreach ($filter_group['datas'] as $filter) {
                            $filterModel = new ConfiguratorStepFilterTypeFeatureModel();
                            $filterModel->id_configurator_step_filter_group = (int) $group->id;
                            $filterModel->type = $filter['values']['type'];
                            $filterModel->id_option = (int) $filter['values']['option'];
                            $filterModel->operator = $filter['values']['operator'];
                            $filterModel->id_target_step = (int) $filter['values']['target_step'];
                            $filterModel->target_type = $filter['values']['target_type'];
                            $filterModel->id_target_option = (int) $filter['values']['target_option'];
                            $filterModel->type_value = $filter['values']['value'];
                            $formula_exist = isset($filter['values']['formula']) && trim($filter['values']['formula']);
                            $filterModel->formula = ($formula_exist) ? $filter['values']['formula'] : null;
                            $filterModel->save();
                        }
                    }
                }
            }
            Configurator::cleanCache();
        }
    }
}
