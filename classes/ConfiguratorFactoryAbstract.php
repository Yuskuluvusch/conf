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

if (!class_exists('ConfiguratorFactoryAbstract')) {
    /**
     * Class ConfiguratorFactoryAbstract
     */
    class ConfiguratorFactoryAbstract
    {
        public static function getType($step_array)
        {
            if (isset($step_array['type'])) {
                return $step_array['type'];
            } else {
                if (isset($step_array['id_configurator_step'])) {
                    $step = ConfiguratorStepFactory::newObject($step_array['id_configurator_step']);
                    if (Validate::isLoadedObject($step)) {
                        return $step->type;
                    }
                }
            }

            return null;
        }

        public static function hydrate($step_array, $id_lang = null)
        {
            $type = self::getType($step_array);
            $step_object = self::createObject($type);

            if ($step_object) {
                $step_object->hydrate($step_array, $id_lang);
                if (method_exists($step_object, 'init')) {
                    $step_object->init();
                }
            }

            return $step_object;
        }

        public static function hydrateCollection($steps_array, $id_lang = null)
        {
            $steps_object = [];

            foreach ($steps_array as $step_array) {
                $steps_object[] = self::hydrate($step_array, $id_lang);
            }

            return $steps_object;
        }

        protected static function createObject($type)
        {
            $object_name = self::getObjectName($type);
            if ($object_name) {
                return new $object_name();
            }

            return null;
        }

        public static function getObjectName($type)
        {
            $types_available = static::getTypesAvailable();
            if (isset($types_available[$type]) && class_exists($types_available[$type])) {
                return $types_available[$type];
            }

            return null;
        }

        public static function getTypesAvailable()
        {
            return null;
        }

        public static function newObject($id_configurator_step, $id_lang = null)
        {
            return null;
        }
    }
}
