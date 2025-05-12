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

if (!class_exists('ConfiguratorStepFilterFactory')) {
    require_once dirname(__FILE__) . '/../ConfiguratorFactoryAbstract.php';

    require_once dirname(__FILE__) . '/ConfiguratorStepFilterAbstract.php';
    require_once dirname(__FILE__) . '/ConfiguratorStepFilterTypeFeatureModel.php';
    require_once dirname(__FILE__) . '/ConfiguratorStepFilterTypeAttributeModel.php';

    /**
     * Class ConfiguratorStepFilterFactory
     */
    class ConfiguratorStepFilterFactory extends ConfiguratorFactoryAbstract
    {
        public static function getTypesAvailable()
        {
            return [
                ConfiguratorStepFilterAbstract::TYPE_FILTER_FEATURES => 'ConfiguratorStepFilterTypeFeatureModel',
                ConfiguratorStepFilterAbstract::TYPE_FILTER_ATTRIBUTES => 'ConfiguratorStepFilterTypeAttributeModel',
            ];
        }

        public static function newObject($id_configurator_step_filter, $id_lang = 0)
        {
            $sql = new DbQuery();
            $sql->select('*');
            $sql->from('configurator_step_filter', 'csf');
            $sql->where('csf.id_configurator_step_filter = ' . (int) $id_configurator_step_filter);
            $results = Db::getInstance()->executeS($sql);

            if (isset($results[0])) {
                $step_array = $results[0];

                return self::hydrate($step_array, $id_lang);
            }

            return null;
        }
    }
}
