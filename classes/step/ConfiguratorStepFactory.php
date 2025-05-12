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

if (!class_exists('ConfiguratorStepFactory')) {
    require_once dirname(__FILE__) . '/../ConfiguratorFactoryAbstract.php';

    require_once dirname(__FILE__) . '/ConfiguratorStepAbstract.php';
    require_once dirname(__FILE__) . '/ConfiguratorStepTypeAttributeModel.php';
    require_once dirname(__FILE__) . '/ConfiguratorStepTypeFeatureModel.php';

    if (Module::isInstalled('dm_upack') && Module::isEnabled('dm_upack')) {
        require_once dirname(__FILE__) . '/../../../dm_upack/classes/step/ConfiguratorStepTypeProductModel.php';
    }
    if (Module::isInstalled('dm_designer') && Module::isEnabled('dm_designer')) {
        require_once dirname(__FILE__) . '/../../../dm_designer/classes/configurator/step/ConfiguratorStepTypeDesignerModel.php';
    }

    /**
     * Class ConfiguratorStepFactory
     */
    class ConfiguratorStepFactory extends ConfiguratorFactoryAbstract
    {
        private static $cache_objects = [];

        public static function getTypesAvailable()
        {
            return [
                ConfiguratorStepAbstract::TYPE_STEP_ATTRIBUTES => 'ConfiguratorStepTypeAttributeModel',
                ConfiguratorStepAbstract::TYPE_STEP_FEATURES => 'ConfiguratorStepTypeFeatureModel',
                ConfiguratorStepAbstract::TYPE_STEP_PRODUCTS => 'ConfiguratorStepTypeProductModel',
                ConfiguratorStepAbstract::TYPE_STEP_UPLOAD => 'ConfiguratorStepTypeAttributeModel',
                ConfiguratorStepAbstract::TYPE_STEP_DESIGNER => 'ConfiguratorStepTypeDesignerModel',
            ];
        }

        public static function newObject($id_configurator_step, $id_lang = null)
        {
            $key = $id_configurator_step . '_' . (is_null($id_lang) ? 'null' : $id_lang);
            if (isset(self::$cache_objects[$key])) {
                return self::$cache_objects[$key];
            }

            $sql = new DbQuery();
            $sql->select('*');
            $sql->from('configurator_step', 'cs');

            if ((int) $id_lang > 0) {
                $sql->innerJoin(
                    'configurator_step_lang',
                    'csl',
                    'cs.id_configurator_step = csl.id_configurator_step AND csl.id_lang = ' . (int) $id_lang
                );
            } else {
                $sql->innerJoin('configurator_step_lang', 'csl', 'cs.id_configurator_step = csl.id_configurator_step');
            }

            $sql->where('cs.id_configurator_step = ' . (int) $id_configurator_step);
            $results = Db::getInstance()->executeS($sql);

            if (isset($results[0])) {
                $step_array = $results[0];
                if ($id_lang === null) {
                    $step_array['name'] = [];
                    $step_array['public_name'] = [];
                    $step_array['invoice_name'] = [];
                    $step_array['input_suffix'] = [];
                    $step_array['content'] = [];
                    $step_array['info_text'] = [];
                    $step_array['header_names'] = [];
                    foreach ($results as $result) {
                        $step_array['name'][$result['id_lang']] = $result['name'];
                        $step_array['public_name'][$result['id_lang']] = $result['public_name'];
                        $step_array['invoice_name'][$result['id_lang']] = $result['invoice_name'];
                        $step_array['input_suffix'][$result['id_lang']] = $result['input_suffix'];
                        $step_array['content'][$result['id_lang']] = $result['content'];
                        $step_array['info_text'][$result['id_lang']] = $result['info_text'];
                        $step_array['header_names'][$result['id_lang']] = $result['header_names'];
                    }
                }

                self::$cache_objects[$key] = self::hydrate($step_array, $id_lang);

                return self::$cache_objects[$key];
            }

            return null;
        }
    }
}
