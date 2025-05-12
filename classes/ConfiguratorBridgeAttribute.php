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

if (!class_exists('ConfiguratorBridgeAttribute') && !class_exists('ProductAttribute')) {
    class ConfiguratorBridgeAttribute extends Attribute
    {
    }
} elseif (!class_exists('ConfiguratorBridgeAttribute')) {
    class ConfiguratorBridgeAttribute extends ProductAttribute
    {
    }
}
