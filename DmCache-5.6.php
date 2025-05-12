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

if (!class_exists('DmCache')) {
    /**
     * Class configuratorCartDetailModel
     * Override AttributeCore of Prestashop
     * We define new properties use in the module
     */
    class DmCache
    {
        private $isPrestashopCache = true;

        private static $_instance;

        private function __construct()
        {
        }

        public static function getInstance()
        {
            if (self::$_instance === null) {
                self::$_instance = new DmCache();
            }

            return self::$_instance;
        }

        /**
         * @param string $key
         * @param string $value
         */
        public function store($key, $value)
        {
            $key = (string) $key;

            return Cache::store($key, $value);
        }

        /**
         * @param string $key
         *
         * @return mixed
         */
        public function retrieve($key)
        {
            $key = (string) $key;

            return Cache::retrieve($key);
        }

        /**
         * @param string $key
         *
         * @return bool
         */
        public function isStored($key)
        {
            $key = (string) $key;

            return Cache::isStored($key);
        }

        /**
         * @param string $key
         */
        public function clean($key = null)
        {
            return Cache::clean($key);
        }
    }
}
