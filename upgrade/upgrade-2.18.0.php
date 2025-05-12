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
 * Function used to update your module from previous versions to the version 2.17.0
 * Don't forget to create one file per version.
 */
function upgrade_module_2_18_0()
{
    $sql = [];
    /*
     * Ajout champ
     */
    $sql[] = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'configurator_step_group` (
		`id_configurator_step_group` int(11) unsigned NOT NULL AUTO_INCREMENT,
                `id_group` int(11) unsigned NOT NULL,
		`id_configurator_step` int(11) unsigned NOT NULL,
		PRIMARY KEY (`id_configurator_step_group`)
	) ENGINE=' . _MYSQL_ENGINE_ . ' DEFAULT CHARSET=utf8;';

    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    return true;
}
