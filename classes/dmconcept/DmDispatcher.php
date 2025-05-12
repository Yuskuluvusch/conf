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

if (!class_exists('DmDispatcher')) {
    /**
     * Class configuratorCartDetailModel
     * Override AttributeCore of Prestashop
     * We define new properties use in the module
     */
    class DmDispatcher extends Dispatcher
    {
        /**
         * Just used to get default_routes.
         * We don't need to load all dispatcher process
         */
        public static function getInstance($request = null)
        {
            return new DmDispatcher($request);
        }

        public function __construct()
        {
            // parent::__construct();
        }
    }
}
