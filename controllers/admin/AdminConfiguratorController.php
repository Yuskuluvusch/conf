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

require_once dirname(__FILE__) . '/../../classes/ConfiguratorModel.php';
require_once dirname(__FILE__) . '/../../classes/helper/DMTools.php';

class AdminConfiguratorController extends ModuleAdminController
{
    public const ADMIN_STEPS_CONTROLLER = 'AdminConfiguratorSteps';

    public function __construct()
    {
        $this->bootstrap = true;

        $this->table = 'configurator';
        $this->className = 'configuratorModel';

        $this->bulk_actions = [
            'delete' => [
                'text' => $this->l('Delete selected'),
                'confirm' => $this->l('Delete selected items?'),
                'icon' => 'icon-trash',
            ],
        ];

        parent::__construct();
    }

    /**
     * translation
     *
     * @param type $string
     * @param type $specific
     *
     * @return type
     */
    public function l($string, $class = null, $addslashes = false, $htmlentities = true)
    {
        $module_name = 'configurator';
        $string = str_replace('\'', '\\\'', $string);

        return Translate::getModuleTranslation($module_name, $string, __CLASS__);
    }

    public function renderList()
    {
        $this->addRowAction('viewstep');
        $this->addRowAction('edit');
        $this->addRowAction('delete');

        $this->fields_list = [
            'id_configurator' => [
                'title' => $this->l('ID'),
            ],
            'id_product' => [
                'title' => $this->l('Product'),
                'callback' => 'getProductName',
            ],
            'active' => [
                'title' => $this->l('Active'),
                'active' => 'status',
            ],
        ];

        $this->context->smarty->assign([
            'configurator_tools_link' => $this->context->link->getAdminLink('AdminConfiguratorTools'),
            'need_tools_update' => DMTools::needToolsUpdate(),
        ]);

        $output = $this->context->smarty->fetch(
            _PS_MODULE_DIR_ . 'configurator/views/templates/admin/need_tools_update.tpl'
        );

        return $output . parent::renderList();
    }

    public function postProcess()
    {
        parent::postProcess();

        Hook::exec('configuratorAdminActionControllerPostProcess');

        if (Tools::getIsset('duplicate_configurator')) {
            $this->duplicateConfigurator();
        }

        // When you come from button actions of product edition (Add configurator, activation, etc...)
        if (Validate::isLoadedObject($product = new Product(Tools::getValue('id_product')))) {
            if ($this->display === 'add') {
                $this->object = new ConfiguratorModel();
                $this->object->id_product = (int) $product->id;
                $this->object->save();
            }

            if (Tools::getIsset('id_product')) {
                $sfContainer = PrestaShop\PrestaShop\Adapter\SymfonyContainer::getInstance();
                if ($sfContainer !== null) {
                    $sfRouter = $sfContainer->get('router');
                    Tools::redirectAdmin(
                        $sfRouter->generate(
                            'admin_product_form',
                            ['id' => Tools::getValue('id_product')]
                        ) . '&show_configurator#tab-hooks'
                    );
                }
            }
        }
    }

    public function processStatus()
    {
        if (Validate::isLoadedObject($object = $this->loadObject())) {
            if ($object->toggleStatus()) {
                $this->redirect_after = '';
                $sfContainer = PrestaShop\PrestaShop\Adapter\SymfonyContainer::getInstance();
                if ($sfContainer !== null) {
                    $sfRouter = $sfContainer->get('router');
                    $this->redirect_after = $sfRouter->generate(
                        'admin_product_form',
                        ['id' => (int) $configurator->id_product]
                    );
                    $this->redirect_after .= '&show_configurator#tab-hooks';
                }
            } else {
                $this->errors[] = $this->trans(
                    'An error occurred while updating the status.',
                    [],
                    'Admin.Notifications.Error'
                );
            }
        } else {
            $error_msg = $this->trans(
                'An error occurred while updating the status for an object.',
                [],
                'Admin.Notifications.Error'
            );
            $error_msg .= ' <b>' . $this->table . '</b> ' . $this->trans(
                '(cannot load object)',
                [],
                'Admin.Notifications.Error'
            );

            $this->errors[] = $error_msg;
        }

        return $object;
    }

    public function renderForm()
    {
        if (!$this->loadObject(true)) {
            return;
        }

        $this->display = Validate::isLoadedObject($this->object) ? 'edit' : 'add';
        $title = Validate::isLoadedObject($this->object)
            ? $this->l('Edit a configurator')
            : $this->l('Add a new configurator for a specific product');

        $hint = 'Commencez à saisir les premières lettres du nom du produit';
        $hint .= ' puis sélectionnez le produit dans le menu déroulant.';

        $this->fields_form = [
            'legend' => [
                'title' => $title,
            ],
            'input' => [
                [
                    'type' => 'select',
                    'label' => $this->l('Product to configure'),
                    'hint' => $this->l($hint),
                    'required' => true,
                    'name' => 'id_product',
                    'col' => '6',
                    'options' => [
                        'query' => $this->getProducts(),
                        'id' => 'id_product',
                        'name' => 'name',
                    ],
                ],
            ],
            'submit' => [
                'title' => $this->l('Save'),
            ],
        ];

        if (Shop::isFeatureActive()) {
            $sql = 'SELECT id_attribute_group, id_shop FROM ' . _DB_PREFIX_ . 'attribute_group_shop';
            $associations = [];
            foreach (Db::getInstance()->executeS($sql) as $row) {
                $associations[$row['id_attribute_group']][] = $row['id_shop'];
            }

            $this->fields_form['input'][] = [
                'type' => 'shop',
                'label' => $this->l('Shop association'),
                'name' => 'checkBoxShopAsso',
                'values' => Shop::getTree(),
            ];
        } else {
            $associations = [];
        }

        $this->fields_form['shop_associations'] = json_encode($associations);

        $parent = parent::renderForm();
        $this->addJqueryPlugin(['autocomplete', 'fancybox', 'typewatch', 'select2']);

        return $parent;
    }

    public function getProductName($echo, $row)
    {
        $echo = true; // Validator
        $product = new Product((int) $row['id_product'], false, $this->context->language->id);

        return Tools::htmlentitiesUTF8($product->name);
    }

    public function displayViewstepLink($token = null, $id = null, $name = null)
    {
        $tpl = $this->createTemplate('helpers/list/list_action_view.tpl');
        if (!array_key_exists('ViewStep', self::$cache_lang)) {
            self::$cache_lang['ViewStep'] = $this->l('See steps');
        }

        $name = self::$cache_lang['ViewStep']; // Validator

        $tpl->assign([
            // Use dispatcher cause we need to set a id_configurator in params
            'href' => Dispatcher::getInstance()->createUrl(
                self::ADMIN_STEPS_CONTROLLER,
                $this->context->language->id,
                [
                    'id_configurator' => (int) $id,
                    'token' => Tools::getAdminTokenLite(self::ADMIN_STEPS_CONTROLLER),
                ],
                false
            ),
            'action' => $name,
            'id' => $id,
            'token' => $token,
        ]);

        return $tpl->fetch();
    }

    private function duplicateConfigurator()
    {
        $product = new Product(Tools::getValue('id_product'));
        if (Validate::isLoadedObject($product)) {
            $has_configurator = ConfiguratorModel::productHasConfigurator((int) $product->id);
            $id_configurator_to_duplicate = Tools::getValue('duplicate_configurator');
            $configurator = new ConfiguratorModel((int) $id_configurator_to_duplicate);
            if (!$has_configurator && $id_configurator_to_duplicate && !$configurator->duplicate((int) $product->id)) {
                $this->context->controller->errors[] = $this->l('An error occured during configuration duplication');
            }
        }
    }

    public function initPageHeaderToolbar()
    {
        if (Module::isInstalled('dm_advancedformula') && Module::isEnabled('dm_advancedformula')) {
            $this->page_header_toolbar_btn['advancedformula_global'] = [
                'href' => $this->context->link->getAdminLink('AdminAdvancedFormulaGlobal'),
                'desc' => $this->l('Global formula'),
                'icon' => 'icon-calculator',
            ];
        }
        parent::initPageHeaderToolbar();
    }

    public function getProducts()
    {
        $products = [];
        foreach ($this->getProductList() as &$product) {
            $products[$product['id_product']] = $product;
        }

        return $products;
    }

    public function getProductList()
    {
        $sql = 'SELECT p.*,
                product_shop.*,
                CONCAT(\'#\', p.`id_product`, \' | \', p.`reference`, \' | \', pl.`name`) AS name,
                c.`id_configurator`
            FROM `' . _DB_PREFIX_ . 'product` p' . Shop::addSqlAssociation('product', 'p') . '
            LEFT JOIN `' . _DB_PREFIX_ . 'product_lang` pl
                ON (p.`id_product` = pl.`id_product` ' . Shop::addSqlRestrictionOnLang('pl') . ')
            LEFT JOIN `' . _DB_PREFIX_ . 'configurator` c
                ON (p.`id_product` = c.`id_product`)
            WHERE pl.`id_lang` = ' . (int) $this->context->language->id . ' AND c.`id_product` IS NULL
            ORDER BY p.`id_product` ASC';

        return Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($sql);
    }
}
