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

if (!class_exists('ConfiguratorStepOptionTypeAttributeModel')) {
    require_once dirname(__FILE__) . '/ConfiguratorStepOptionAbstract.php';

    require_once dirname(__FILE__) . '/../ConfiguratorAttribute.php';

    /**
     * Class ConfiguratorStepOptionTypeAttributeModel
     */
    class ConfiguratorStepOptionTypeAttributeModel extends ConfiguratorStepOptionAbstract
    {
        public function __construct($id = null, $id_lang = null, $id_shop = null)
        {
            parent::__construct($id, $id_lang, $id_shop);
        }

        public function fillOption()
        {
            $option = (array) new ConfiguratorAttribute(
                (int) $this->id_option,
                Context::getContext()->language->id
            );
            $this->option = $option;
        }
    }
}
