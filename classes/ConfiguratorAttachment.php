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

class ConfiguratorAttachment extends ObjectModel
{
    public $file;
    public $file_name;
    public $file_size;
    public $mime;
    public $token;

    /**
     * @see ObjectModel::$definition
     */
    public static $definition = [
        'table' => 'configurator_attachment',
        'primary' => 'id_configurator_attachment',
        'fields' => [
            'file' => [
                'type' => self::TYPE_STRING,
                'validate' => 'isGenericName',
                'required' => true,
                'size' => 40,
            ],
            'mime' => [
                'type' => self::TYPE_STRING,
                'validate' => 'isCleanHtml',
                'required' => true,
                'size' => 128,
            ],
            'token' => ['type' => self::TYPE_STRING, 'validate' => 'isString', 'required' => true, 'size' => 50],
            'file_name' => ['type' => self::TYPE_STRING, 'validate' => 'isGenericName', 'size' => 128],
            'file_size' => ['type' => self::TYPE_INT, 'validate' => 'isUnsignedId'],
        ],
    ];

    public function add($autodate = true, $null_values = false)
    {
        $this->file_size = filesize(_PS_DOWNLOAD_DIR_ . $this->file);

        return parent::add($autodate, $null_values);
    }

    public function update($null_values = false)
    {
        $this->file_size = filesize(_PS_DOWNLOAD_DIR_ . $this->file);

        return parent::update($null_values);
    }

    public function delete()
    {
        @unlink(_PS_DOWNLOAD_DIR_ . $this->file);
        Db::getInstance()->execute(
            'DELETE FROM ' . _DB_PREFIX_ . 'configurator_cartdetail_attachment'
            . ' WHERE id_configurator_attachment = ' . (int) $this->id
        );

        return parent::delete();
    }

    public function deleteSelection($attachments)
    {
        $return = 1;
        foreach ($attachments as $id_attachment) {
            $attachment = new ConfiguratorAttachment((int) $id_attachment);
            $return &= $attachment->delete();
        }

        return $return;
    }

    public static function getAttachments($id_configurator_cart_detail, $id_step = null, $include = true)
    {
        return Db::getInstance()->executeS(
            'SELECT *
			FROM ' . _DB_PREFIX_ . 'configurator_attachment a
			WHERE a.id_configurator_attachment ' . ($include ? 'IN' : 'NOT IN') . ' (
				SELECT pa.id_configurator_attachment
				FROM ' . _DB_PREFIX_ . 'configurator_cartdetail_attachment pa
				WHERE id_configurator_cart_detail = ' . (int) $id_configurator_cart_detail . '
                ' . (!is_null($id_step) ? ' AND id_step = ' . (int) $id_step : '') . '
			)'
        );
    }

    public static function getAttachmentByToken($token)
    {
        $query = new DbQuery();
        $query->select('*')
            ->from('configurator_attachment')
            ->where('token = "' . pSQL($token) . '"');

        $res = Db::getInstance()->getRow($query);
        $attachment = new ConfiguratorAttachment();

        if (!$res) {
            return $attachment;
        }

        $attachment->hydrate($res);

        return $attachment;
    }

    /**
     * associate $id_product to the current object.
     *
     * @param int $id_configurator_cart_detail id of the product to associate
     *
     * @return bool true if succed
     */
    public function attachCartDetail($id_configurator_cart_detail, $id_step)
    {
        $res = Db::getInstance()->execute('
			INSERT INTO ' . _DB_PREFIX_ . 'configurator_cartdetail_attachment
				(id_configurator_attachment, id_configurator_cart_detail, id_step) VALUES
				(' . (int) $this->id . ', ' . (int) $id_configurator_cart_detail . ', ' . (int) $id_step . ')');

        return $res;
    }

    public static function getAttachmentByProduct($id_configurator_cart_detail)
    {
        $sql = 'SELECT a.* FROM ' . _DB_PREFIX_ . 'configurator_attachment a, `'
            . _DB_PREFIX_ . 'configurator_cartdetail_attachment` ca, `'
            . _DB_PREFIX_ . 'configurator_cart_detail` cd
            WHERE a.`id_configurator_attachment` = ca.`id_configurator_attachment`
            AND ca.`id_configurator_cart_detail` = cd.`id_configurator_cart_detail`
            AND ca.`id_configurator_cart_detail` = ' . (int) $id_configurator_cart_detail;

        return Db::getInstance()->executeS($sql);
    }
}
