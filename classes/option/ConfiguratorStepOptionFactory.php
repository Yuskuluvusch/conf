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

if (!class_exists('ConfiguratorStepOptionFactory')) {
    require_once dirname(__FILE__) . '/../ConfiguratorFactoryAbstract.php';

    require_once dirname(__FILE__) . '/../step/ConfiguratorStepAbstract.php';
    require_once dirname(__FILE__) . '/../step/ConfiguratorStepFactory.php';
    require_once dirname(__FILE__) . '/ConfiguratorStepOptionAbstract.php';
    require_once dirname(__FILE__) . '/ConfiguratorStepOptionTypeAttributeModel.php';

    if (Module::isInstalled('dm_upack') && Module::isEnabled('dm_upack')) {
        require_once dirname(__FILE__) . '/../../../dm_upack/classes/option/ConfiguratorStepOptionTypeProductModel.php';
    }

    /**
     * Class ConfiguratorStepOptionFactory
     */
    class ConfiguratorStepOptionFactory extends ConfiguratorFactoryAbstract
    {
        private static $cache_objects = [];

        public static function getTypesAvailable()
        {
            return [
                ConfiguratorStepAbstract::TYPE_STEP_ATTRIBUTES => 'ConfiguratorStepOptionTypeAttributeModel',
                ConfiguratorStepAbstract::TYPE_STEP_FEATURES => 'ConfiguratorStepOptionTypeFeatureModel',
                ConfiguratorStepAbstract::TYPE_STEP_PRODUCTS => 'ConfiguratorStepOptionTypeProductModel',
                ConfiguratorStepAbstract::TYPE_STEP_UPLOAD => 'ConfiguratorStepOptionTypeAttributeModel',
            ];
        }

        public static function newObject($id_configurator_step_option, $id_lang = null)
        {
            $key = $id_configurator_step_option . '_' . (is_null($id_lang) ? 'null' : $id_lang);
            if (isset(self::$cache_objects[$key])) {
                return self::$cache_objects[$key];
            }

            $sql = new DbQuery();
            $sql->select('cso.*, csol.*, cs.type');
            $sql->from('configurator_step_option', 'cso');

            if ($id_lang !== null) {
                $sql->innerJoin(
                    'configurator_step_option_lang',
                    'csol',
                    'cso.id_configurator_step_option = csol.id_configurator_step_option'
                        . ' AND csol.id_lang = ' . (int) $id_lang
                );
            } else {
                $sql->innerJoin(
                    'configurator_step_option_lang',
                    'csol',
                    'cso.id_configurator_step_option = csol.id_configurator_step_option'
                );
            }

            $sql->innerJoin('configurator_step', 'cs', 'cs.id_configurator_step = cso.id_configurator_step');
            $sql->where('cso.id_configurator_step_option = ' . (int) $id_configurator_step_option);
            $results = Db::getInstance()->executeS($sql);

            if (isset($results[0])) {
                $option_array = $results[0];
                if ($id_lang === null) {
                    $option_array['content'] = [];
                    $option_array['placeholder'] = [];
                    foreach ($results as $result) {
                        $option_array['content'][$result['id_lang']] = $result['content'];
                        $option_array['placeholder'][$result['id_lang']] = $result['placeholder'];
                    }
                }

                self::$cache_objects[$key] = self::hydrate($option_array);

                return self::$cache_objects[$key];
            }

            return null;
        }
    }
}
