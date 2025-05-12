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

require_once dirname(__FILE__) . '/../../classes/ConfiguratorAttachment.php';

class ConfiguratorAttachmentModuleFrontController extends ModuleFrontController
{
    public function postProcess()
    {
        $a = ConfiguratorAttachment::getAttachmentByToken(Tools::getValue('token'));
        if (!Validate::isLoadedObject($a)) {
            Tools::redirect('index.php');
        }

        if (ob_get_level() && ob_get_length() > 0) {
            ob_end_clean();
        }

        $action = Tools::getValue('action');
        if ($action === 'delete') {
            $a->delete();
            exit(json_encode([
                'success' => true,
            ]));
        }

        header('Content-Transfer-Encoding: binary');
        header('Content-Type: ' . $a->mime);
        header('Content-Length: ' . filesize(_PS_DOWNLOAD_DIR_ . $a->file));
        header('Content-Disposition: attachment; filename="' . mb_convert_encoding($a->file_name, 'UTF-8', mb_detect_encoding($a->file_name)) . '"');
        @set_time_limit(0);
        readfile(_PS_DOWNLOAD_DIR_ . $a->file);
        exit;
    }
}
