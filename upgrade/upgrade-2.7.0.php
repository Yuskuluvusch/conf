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
 * Function used to update your module from previous versions to the version 2.5.0
 * Don't forget to create one file per version.
 */
function upgrade_module_2_7_0()
{
    $sql = [];
    /*
     * Changement
     */
    $sql[] = 'ALTER TABLE `' . _DB_PREFIX_ . 'configurator_step_attribute` 
        CHANGE `impact_type` `impact_type` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;';
    foreach ($sql as $query) {
        if (Db::getInstance()->execute($query) === false) {
            return false;
        }
    }

    return true;
}
