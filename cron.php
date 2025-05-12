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

require_once dirname(__FILE__) . '/../../config/config.inc.php';
require_once 'configurator.php';

if (DMTools::isCli()) {
    parse_str(implode('&', array_slice($argv, 1)), $_GET);
    $_GET['token'] = md5(_COOKIE_KEY_);
}

$module = new Configurator();
if (!Module::isInstalled($module->name)) {
    exit;
}

if (Tools::getValue('token') !== md5(_COOKIE_KEY_)) {
    exit;
}

switch (Tools::getValue('action')) {
    case 'delete_empty_cart':
        DMTools::deleteUnusedCartDetail((int) Tools::getValue('number', 1), (int) Tools::getValue('day', 2));
        break;
    case 'delete_old_cart':
        DMTools::deleteOldCart((int) Tools::getValue('number', 1), (int) Tools::getValue('day', 2), (int) Tools::getValue('with_customer', 0), (int) Tools::getValue('without_customized_data', 1));
        break;
    case 'delete_cart_details_without_guest':
        DMTools::deleteCartDetailsWithoutGuest((int) Tools::getValue('number', 1), (int) Tools::getValue('day', 2), (int) Tools::getValue('without_customized_data', 1));
        break;
    case 'clean_customized_data':
        DMTools::cleanCustomizedData();
        break;
    case 'delete_cart_details_without_cart':
        DMTools::deleteCartDetailsWithoutCart((int) Tools::getValue('number', 1));
        break;
}

exit('Cron finished');
