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

if (!class_exists('ConfiguratorStepTypeFeatureModel')) {
    require_once dirname(__FILE__) . '/ConfiguratorStepAbstract.php';

    require_once dirname(__FILE__) . '/../option/ConfiguratorStepOptionTypeFeatureModel.php';
    require_once dirname(__FILE__) . '/../../DmCache.php';

    /**
     * Class ConfiguratorStepTypeFeatureModel
     */
    class ConfiguratorStepTypeFeatureModel extends ConfiguratorStepAbstract
    {
        public function __construct($id = null, $id_lang = null, $id_shop = null)
        {
            parent::__construct($id, $id_lang, $id_shop);
        }

        public static function getGroupsAvailable($id_lang)
        {
            $groups = [];
            $features_group = Feature::getFeatures($id_lang);
            foreach ($features_group as $feature_group) {
                $groups[] = [
                    'id_option_group' => $feature_group['id_feature'],
                    'name' => $feature_group['name'],
                ];
            }

            return $groups;
        }

        public function getOptions($lang_id, $only_used = true)
        {
            $key = 'ConfiguratorStepTypeFeatureModel::getOptions-' . $lang_id
                . '-' . (int) $this->id . '-' . ($only_used ? 'notall' : 'all');
            if (DmCache::getInstance()->isStored($key)) {
                return DmCache::getInstance()->retrieve($key);
            } else {
                // Get products in the current step category
                $feature_values = $this->getOptionsFromOptionGroup((int) $lang_id);

                // Get active options step
                $query = new DbQuery();
                $query->select('*')
                    ->from('configurator_step_option', 'cso')
                    ->innerJoin(
                        'configurator_step_option_lang',
                        'csol',
                        'cso.id_configurator_step_option = csol.id_configurator_step_option'
                        . ' AND csol.id_lang = ' . (int) $lang_id
                    )
                    ->where('id_configurator_step = ' . (int) $this->id)
                    ->orderBy('position ASC');
                $results = Db::getInstance()->executeS($query, true, false);

                foreach ($results as $k => $result) {
                    $results[$k]['content'] = [$lang_id => $result['content']];
                }

                $options = ConfiguratorStepOptionFactory::hydrateCollection($results);

                foreach ($feature_values as $feature_value) {
                    $used = false;
                    foreach ($options as $key => $option) {
                        if ((int) $option->id_option === (int) $feature_value['id_feature_value']) {
                            $options[$key]->option = $feature_value;
                            $options[$key]->ipa = 0;
                            $used = (int) $key;
                            break;
                        }
                    }

                    if (!$only_used && $used === false) {
                        $configuratorStepOption = new ConfiguratorStepOptionTypeFeatureModel();
                        $configuratorStepOption->option = $feature_value;
                        $configuratorStepOption->id_option = (int) $feature_value['id_feature_value'];
                        $configuratorStepOption->ipa = 0;
                        $options[] = $configuratorStepOption;
                    }
                }

                $pos = 0;
                foreach ($options as $key => $option) {
                    if (is_null($option->option)) {
                        unset($options[$key]);
                    } else {
                        $options[$key]->position = $pos;
                        ++$pos;
                    }
                }

                DmCache::getInstance()->store($key, $options);

                return $options;
            }
        }

        public function getOptionsFromOptionGroup($id_lang)
        {
            $key = 'ConfiguratorStepTypeFeatureModel::getOptionsFromOptionGroup-' . (int) $id_lang;
            if (DmCache::getInstance()->isStored($key)) {
                $options = DmCache::getInstance()->retrieve($key);
            } else {
                $options = Db::getInstance()->executeS('
                    SELECT *
                    FROM `' . _DB_PREFIX_ . 'feature_value` fv
                    ' . Shop::addSqlAssociation('feature_value', 'fv') . '
                    LEFT JOIN `' . _DB_PREFIX_ . 'feature_value_lang` fvl
                    ON (fv.`id_feature_value` = fvl.`id_feature_value` AND fvl.`id_lang` = ' . (int) $id_lang . ')
                ');
                DmCache::getInstance()->store($key, $options);
            }

            $key = 'ConfiguratorStepTypeFeatureModel::getOptionsFromOptionGroup-' . (int) $id_lang
                . '-' . (int) $this->id_option_group;
            if (DmCache::getInstance()->isStored($key)) {
                return DmCache::getInstance()->retrieve($key);
            } else {
                $return = [];
                foreach ($options as $option) {
                    if ($option['id_feature'] == $this->id_option_group) {
                        $option['name'] = $option['value'];
                        $return[] = $option;
                    }
                }
                DmCache::getInstance()->store($key, $return);

                return $return;
            }
        }
    }
}
