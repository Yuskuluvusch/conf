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

function upgrade_module_5_1_2($module)
{
    $lang_values = [];
    foreach (Language::getLanguages() as $lang) {
        $lang_values[$lang['id_lang']] = $module->l('Configurator', false, $lang['locale']);
    }

    $module->setConfigurationLang('CONFIGURATOR_CUSTOMIZATION_FIELD_NAME', $lang_values);

    return true;
}
