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

if (!class_exists('ConfiguratorStepTypeAttributeModel')) {
    require_once dirname(__FILE__) . '/ConfiguratorStepAbstract.php';

    require_once dirname(__FILE__) . '/../option/ConfiguratorStepOptionTypeAttributeModel.php';
    require_once dirname(__FILE__) . '/../../DmCache.php';

    /**
     * Class ConfiguratorStepTypeAttributeModel
     */
    class ConfiguratorStepTypeAttributeModel extends ConfiguratorStepAbstract
    {
        public function __construct($id = null, $id_lang = null, $id_shop = null)
        {
            parent::__construct($id, $id_lang, $id_shop);
        }

        public static function getGroupsAvailable($id_lang)
        {
            $groups = [];
            $attributes_group = AttributeGroup::getAttributesGroups($id_lang);
            foreach ($attributes_group as $attribute_group) {
                $groups[] = [
                    'id_option_group' => $attribute_group['id_attribute_group'],
                    'name' => $attribute_group['name'],
                ];
            }

            return $groups;
        }

        public function getOptions($lang_id, $only_used = true)
        {
            $key = 'ConfiguratorStepTypeAttributeModel::getOptions-' . $lang_id
                . '-' . (int) $this->id . '-' . ($only_used ? 'notall' : 'all');
            if (DmCache::getInstance()->isStored($key)) {
                return DmCache::getInstance()->retrieve($key);
            } else {
                // Get products in the current step category
                $attributes = $this->getOptionsFromOptionGroup((int) $lang_id);

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

                foreach ($attributes as $attribute) {
                    $used = false;
                    foreach ($options as $key => $option) {
                        if ((int) $option->id_option === (int) $attribute['id_attribute']) {
                            $options[$key]->option = $attribute;
                            $options[$key]->ipa = 0;
                            $used = (int) $key;
                            break;
                        }
                    }

                    if (!$only_used && $used === false) {
                        $configuratorStepOption = new ConfiguratorStepOptionTypeAttributeModel();
                        $configuratorStepOption->option = $attribute;
                        $configuratorStepOption->id_option = (int) $attribute['id_attribute'];
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
            $key = 'ConfiguratorStepTypeAttributeModel::getOptionsFromOptionGroup-' . (int) $id_lang;
            if (DmCache::getInstance()->isStored($key)) {
                $options = DmCache::getInstance()->retrieve($key);
            } else {
                // Fix : lenteur quand il y a beaucoup d'attributs
                // (dont les attributs générées par l'ancienne version)
                $id_attribute_group_configurator = (int) Configuration::get('CONFIGURATOR_ATTRIBUTEGROUP_ID');
                $sql = ($id_attribute_group_configurator > 0)
                    ? ' WHERE a.id_attribute_group <> ' . $id_attribute_group_configurator . ' '
                    : '';

                $options = Db::getInstance()->executeS('
                    SELECT *
                    FROM `' . _DB_PREFIX_ . 'attribute` a
                    ' . Shop::addSqlAssociation('attribute', 'a') . '
                    LEFT JOIN `' . _DB_PREFIX_ . 'attribute_lang` al
                    ON (a.`id_attribute` = al.`id_attribute` AND al.`id_lang` = ' . (int) $id_lang . ')
                    ' . $sql . '
                    ORDER BY `position` ASC
                ');
                DmCache::getInstance()->store($key, $options);
            }

            $key = 'ConfiguratorStepTypeAttributeModel::getOptionsFromOptionGroup-' . (int) $id_lang
                . '-' . (int) $this->id_option_group;
            if (DmCache::getInstance()->isStored($key)) {
                return DmCache::getInstance()->retrieve($key);
            } else {
                $return = [];
                foreach ($options as $option) {
                    if ($option['id_attribute_group'] == $this->id_option_group) {
                        $return[] = $option;
                    }
                }
                DmCache::getInstance()->store($key, $return);

                return $return;
            }
        }

        public function getUploadedFilesSize($configurator_cart_detail)
        {
            $attachments = ConfiguratorAttachment::getAttachments($configurator_cart_detail->id, $this->id);
            $total = 0;
            foreach ($attachments as $attachment) {
                $total += (int) $attachment['file_size'];
            }

            return $total;
        }

        public function getMaxFilesSize()
        {
            return (int) $this->max_weight_total * 1024 * 1024; // Mo
        }
    }
}
