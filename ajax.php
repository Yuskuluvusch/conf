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

require_once getcwd() . '/../../config/config.inc.php';

if (Tools::isSubmit('getidsproductduplicated')) {
    $query = new DbQuery();
    $query->select('id_product')
        ->from('product')
        ->where('is_configurated = 1');

    $ids = [];
    $results = Db::getInstance()->executeS($query);

    foreach ($results as $r) {
        $ids[] = (int) $r['id_product'];
    }

    exit(json_encode($ids));
}

exit;
