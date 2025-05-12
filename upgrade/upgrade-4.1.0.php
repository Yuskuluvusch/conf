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

/**
 * Function used to update your module from previous versions to the version 4.0.0
 * Don't forget to create one file per version.
 *
 * @param ModuleCore $module
 *
 * @return bool
 */
function upgrade_module_4_1_0()
{
    $sql = [];

    $sql[] = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'configurator_step_filter_group` (
      `id_configurator_step_filter_group` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
      `id_configurator_step` int(10) UNSIGNED NOT NULL,
      `id_configurator_step_option` int(10) UNSIGNED NOT NULL,
      PRIMARY KEY (`id_configurator_step_filter_group`)
    ) ENGINE=' . _MYSQL_ENGINE_ . ' DEFAULT CHARSET=utf8;';

    $sql[] = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'configurator_step_filter` (
      `id_configurator_step_filter` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
      `id_configurator_step_filter_group` int(10) UNSIGNED NOT NULL,
      `type` varchar(30) NOT NULL,
      `id_option` int(10) UNSIGNED NOT NULL,
      `operator` varchar(30) NOT NULL,
      `id_target_step` int(10) UNSIGNED NOT NULL,
      `target_type` varchar(30) NOT NULL,
      `id_target_option` int(10) UNSIGNED NOT NULL,
      `type_value` varchar(30) NOT NULL,
      PRIMARY KEY (`id_configurator_step_filter`)
    ) ENGINE=' . _MYSQL_ENGINE_ . ' DEFAULT CHARSET=utf8;';

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    return true;
}
