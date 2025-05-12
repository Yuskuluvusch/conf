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
function upgrade_module_2_19_4($module)
{
    /**
     * This feature is long to execute
     */
    // $module->updateConfiguratorCustomizationField();

    $success = true;
    $success &= $module->uninstallOverrides();
    $success &= $module->installOverrides();

    return $success;
}

/*
 * REMOVE id_product OF configurator_cart_detail
 * REMOVE attribute_key OF configurator_cart_detail
 */
