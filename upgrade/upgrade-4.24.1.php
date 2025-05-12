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

require_once dirname(__FILE__) . '/../classes/filter/ConfiguratorStepFilterAbstract.php';

/**
 * Function used to update your module from previous versions to the version 4.24.1
 * Don't forget to create one file per version.
 *
 * @param ModuleCore $module
 *
 * @return bool
 */
function upgrade_module_4_24_1($module)
{
    $convert = [
        '=' => 'EQUAL',
        '%LIKE%' => 'CONTAINS',
        '%CONTAINED%' => 'CONTAINED',
        '>' => 'UPPER',
        '>=' => 'UPPER_OR_EQUAL',
        '<' => 'LOWER',
        '<=' => 'LOWER_OR_EQUAL',
        '=NUMBER' => 'EQUAL_NUMBER',
        '>NUMBER' => 'UPPER_NUMBER',
        '>=NUMBER' => 'UPPER_OR_EQUAL_NUMBER',
        '<NUMBER' => 'LOWER_NUMBER',
        '<=NUMBER' => 'LOWER_OR_EQUAL_NUMBER',
        '=FORMULA' => 'EQUAL_FORMULA',
        '>FORMULA' => 'UPPER_FORMULA',
        '>=FORMULA' => 'UPPER_OR_EQUAL_FORMULA',
        '<FORMULA' => 'LOWER_FORMULA',
        '<=FORMULA' => 'LOWER_OR_EQUAL_FORMULA',
    ];
    $filters = ConfiguratorStepFilterAbstract::getFilters();
    foreach ($filters as $filter) {
        if (!$filter->operator) {
            $filter->delete();
        } elseif (isset($convert[$filter->operator])) {
            $filter->operator = $convert[$filter->operator];
            $filter->save();
        }
    }

    $success = $module->registerHook('actionObjectFeatureValueDeleteAfter');

    return $success;
}
