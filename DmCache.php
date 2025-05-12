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

if (version_compare(phpversion(), '7.0', '>')) {
    require dirname(__FILE__) . '/DmCache-7.0.php';
} else {
    require dirname(__FILE__) . '/DmCache-5.6.php';
}
