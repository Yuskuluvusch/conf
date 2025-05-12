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

require __DIR__ . '/vendor/autoload.php';

use Phpfastcache\CacheManager;
use Phpfastcache\Config\ConfigurationOption;

if (!defined('_CAN_LOAD_FILES_')) {
    exit;
}

if (!class_exists('DmCache')) {
    // https://code.tutsplus.com/tutorials/boost-your-website-performance-with-phpfastcache--cms-31031

    /**
     * Class configuratorCartDetailModel
     * Override AttributeCore of Prestashop
     * We define new properties use in the module
     */
    class DmCache
    {
        private $isPrestashopCache;

        private static $_instance;

        protected $fastcache;

        private function __construct()
        {
            $this->isPrestashopCache = (bool) Configuration::get('CONFIGURATOR_CACHE_PS');
            if (!$this->isPrestashopCache) {
                CacheManager::setDefaultConfig(new ConfigurationOption([
                    'path' => __DIR__ . "\cache",
                ]));

                $this->fastcache = CacheManager::getInstance('files');
            }
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

            if ($this->isPrestashopCache) {
                return Cache::store($key, $value);
            }

            $cache = $this->fastcache->getItem($key);
            $cache->set($value)->expiresAfter(86400); // 1 journée

            return $this->fastcache->save($cache);
        }

        /**
         * @param string $key
         *
         * @return mixed
         */
        public function retrieve($key)
        {
            $key = (string) $key;

            if ($this->isPrestashopCache) {
                return Cache::retrieve($key);
            }
            $cache = $this->fastcache->getItem($key);

            return $cache->get();
        }

        /**
         * @param string $key
         *
         * @return bool
         */
        public function isStored($key)
        {
            $key = (string) $key;

            if ($this->isPrestashopCache) {
                return Cache::isStored($key);
            }

            $cache = $this->fastcache->getItem($key);

            return !is_null($cache->get());
        }

        /**
         * @param string $key
         */
        public function clean($key = null)
        {
            if ($this->isPrestashopCache) {
                return Cache::clean($key);
            }

            // fastcache deleteall
            // A tester
            $this->fastcache->clear();
        }
    }
}
