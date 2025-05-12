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
class AdminConfiguratorTabsController extends ModuleAdminController
{
    private $_id_configurator;

    public function __construct()
    {
        $this->bootstrap = true;

        $this->table = 'configurator_step_tab';
        $this->className = 'configuratorStepTabModel';
        $this->lang = true;

        parent::__construct();

        $this->_id_configurator = (int) Tools::getValue('id_configurator');
    }

    public function ajaxProcessDelete()
    {
        $id = Tools::getValue('id');
        $tab = new ConfiguratorStepTabModel((int) $id);

        $return = [
            'success' => 0,
            'message' => '',
        ];

        if (Validate::isLoadedObject($tab)) {
            $return['success'] = (int) $tab->delete();
            if ((bool) $return['success']) {
                $return['message'] = $this->l('The tab has been successfully deleted.');
            } else {
                $return['message'] = $this->l('An error occurred, the tab hasn\'t been deleted');
            }
        } else {
            $return['message'] = $this->l('An error occurred, the tab doesn\'t exist.');
        }

        $this->ajaxDie(json_encode($return));
    }

    public function ajaxProcessAdd()
    {
        $id_configurator = Tools::getValue('id_configurator');
        $return = [
            'success' => 0,
            'message' => '',
        ];
        $tab = new ConfiguratorStepTabModel();
        $tab->id_configurator = $id_configurator;
        foreach (Language::getLanguages() as $lang) {
            $tab->name[$lang['id_lang']] = Tools::getValue('name_' . $lang['id_lang']);
        }
        $return['success'] = (int) $tab->add();
        if ((bool) $return['success']) {
            $return['message'] = $this->l('The tab has been successfully added.');
            $return['tab'] = $tab;
        } else {
            $return['message'] = $this->l('An error occurred, the tab hasn\'t been added');
        }

        $this->ajaxDie(json_encode($return));
    }

    public function ajaxProcessUpdate()
    {
        $id = Tools::getValue('id');

        $return = [
            'success' => 0,
            'message' => '',
        ];
        $tab = new ConfiguratorStepTabModel($id);
        if (Validate::isLoadedObject($tab)) {
            foreach (Language::getLanguages() as $lang) {
                $tab->name[$lang['id_lang']] = Tools::getValue('name_' . $lang['id_lang']);
            }
            $return['success'] = (int) $tab->update();
            if ((bool) $return['success']) {
                $return['message'] = $this->l('The tab has been successfully updated.');
                $return['tab'] = $tab;
            } else {
                $return['message'] = $this->l('An error occurred, the tab hasn\'t been updated');
            }
        } else {
            $return['message'] = $this->l('An error occurred, the tab doesn\'t exist.');
        }

        $this->ajaxDie(json_encode($return));
    }

    public function ajaxProcessPosition()
    {
        $id = Tools::getValue('id');
        $type = Tools::getValue('type');
        $tab = new ConfiguratorStepTabModel((int) $id);

        $return = [
            'success' => 0,
            'message' => '',
        ];

        if (Validate::isLoadedObject($tab)) {
            $tabs = ConfiguratorStepTabModel::getTabsByIdConfigurator($tab->id_configurator);
            $pos = 0;
            foreach ($tabs as $k => $t) {
                $tabs[$k]->position = (int) $pos;
                if ((int) $t->id === (int) $tab->id) {
                    if ($type === 'down') {
                        ++$tabs[$k]->position;
                    } elseif ($type === 'up') {
                        --$tabs[$k]->position;
                    }
                    $p = $tabs[$k]->position;
                }
                ++$pos;
            }
            foreach ($tabs as $k => $t) {
                if ((int) $p === $tabs[$k]->position && (int) $t->id !== (int) $tab->id) {
                    if ($type === 'down') {
                        --$tabs[$k]->position;
                    } elseif ($type === 'up') {
                        ++$tabs[$k]->position;
                    }
                }
                $t->save();
            }

            $return['success'] = (int) true;
            if ((bool) $return['success']) {
                $return['message'] = $this->l('The tab has been successfully updated.');
            } else {
                $return['message'] = $this->l('An error occurred, the tab hasn\'t been updated');
            }
        } else {
            $return['message'] = $this->l('An error occurred, the tab doesn\'t exist.');
        }

        $this->ajaxDie(json_encode($return));
    }
}
