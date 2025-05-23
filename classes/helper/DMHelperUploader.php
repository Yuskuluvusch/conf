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

class DMHelperUploader extends Uploader
{
    public const DEFAULT_TEMPLATE_DIRECTORY = 'modules/configurator/views/templates/front/helpers/uploader';
    public const DEFAULT_TEMPLATE = 'simple.tpl';
    public const DEFAULT_AJAX_TEMPLATE = 'ajax.tpl';

    public const TYPE_IMAGE = 'image';
    public const TYPE_FILE = 'file';

    private $_context;
    private $_drop_zone;
    private $_id;
    private $_files;
    private $_name;
    private $_max_files;
    private $_multiple;
    private $_post_max_size;
    protected $_template;
    private $_template_directory;
    private $_title;
    private $_url;
    private $_use_ajax;

    private $use_upload_camera;
    private $show_upload_image;
    private $display_progress = false;

    public function setContext($value)
    {
        $this->_context = $value;

        return $this;
    }

    public function getContext()
    {
        if (!isset($this->_context)) {
            $this->_context = Context::getContext();
        }

        return $this->_context;
    }

    public function setDropZone($value)
    {
        $this->_drop_zone = $value;

        return $this;
    }

    public function getDropZone()
    {
        if (!isset($this->_drop_zone)) {
            $this->setDropZone('#' . $this->getId() . '-add-button');
        }

        return $this->_drop_zone;
    }

    public function setId($value)
    {
        $this->_id = (string) $value;

        return $this;
    }

    public function getId()
    {
        if (!isset($this->_id) || trim($this->_id) === '') {
            $this->_id = $this->getName();
        }

        return $this->_id;
    }

    public function setFiles($value)
    {
        $this->_files = $value;

        return $this;
    }

    public function getFiles()
    {
        if (!isset($this->_files)) {
            $this->_files = [];
        }

        return $this->_files;
    }

    public function setMaxFiles($value)
    {
        $this->_max_files = isset($value) ? (int) $value : $value;

        return $this;
    }

    public function getMaxFiles()
    {
        return $this->_max_files;
    }

    public function setMultiple($value)
    {
        $this->_multiple = (bool) $value;

        return $this;
    }

    public function setName($value)
    {
        $this->_name = (string) $value;

        return $this;
    }

    public function getName()
    {
        return $this->_name;
    }

    public function setPostMaxSize($value)
    {
        $this->_post_max_size = $value;
        $this->setMaxSize($value);

        return $this;
    }

    public function getPostMaxSize()
    {
        if (!isset($this->_post_max_size)) {
            $this->_post_max_size = parent::getPostMaxSize();
        }

        return $this->_post_max_size;
    }

    public function setTemplate($value)
    {
        $this->_template = $value;

        return $this;
    }

    public function getTemplate()
    {
        if (!isset($this->_template)) {
            $this->setTemplate(self::DEFAULT_TEMPLATE);
        }

        return $this->_template;
    }

    public function setTemplateDirectory($value)
    {
        $this->_template_directory = $value;

        return $this;
    }

    public function getTemplateDirectory()
    {
        if (!isset($this->_template_directory)) {
            $this->_template_directory = self::DEFAULT_TEMPLATE_DIRECTORY;
        }

        if (method_exists($this, '_normalizeDirectory')) {
            return $this->_normalizeDirectory($this->_template_directory);
        }

        return $this->normalizeDirectory($this->_template_directory);
    }

    public function getTemplateFile($template)
    {
        return $this->getTemplateDirectory() . $template;
    }

    public function setTitle($value)
    {
        $this->_title = $value;

        return $this;
    }

    public function getTitle()
    {
        return $this->_title;
    }

    public function setUrl($value)
    {
        $this->_url = (string) $value;

        return $this;
    }

    public function getUrl()
    {
        return $this->_url;
    }

    public function setUseAjax($value)
    {
        $this->_use_ajax = (bool) $value;

        return $this;
    }

    public function isMultiple()
    {
        return isset($this->_multiple) && $this->_multiple;
    }

    public function render()
    {
        /*
        $this->getContext()->controller->addJs(_PS_MODULE_DIR_
            .'configurator/views/js/fileupload/jquery.iframe-transport.js');
        $this->getContext()->controller->addJs(_PS_MODULE_DIR_
            .'configurator/views/js/fileupload/jquery.fileupload.js');
        $this->getContext()->controller->addJs(_PS_MODULE_DIR_
            .'configurator/views/js/fileupload/jquery.fileupload-process.js');
        $this->getContext()->controller->addJs(_PS_MODULE_DIR_
            .'configurator/views/js/fileupload/jquery.fileupload-validate.js');
        $this->getContext()->controller->addJs(__PS_BASE_URI__.'js/vendor/spin.js');
        $this->getContext()->controller->addJs(__PS_BASE_URI__.'js/vendor/ladda.js');
*/
        if ($this->useAjax() && !isset($this->_template)) {
            $this->setTemplate(self::DEFAULT_AJAX_TEMPLATE);
        }

        $template = $this->getContext()->smarty->createTemplate(
            $this->getTemplateFile($this->getTemplate()),
            $this->getContext()->smarty
        );

        $template->assign([
            'id' => $this->getId(),
            'name' => $this->getName(),
            'url' => $this->getUrl(),
            'multiple' => $this->isMultiple(),
            'files' => $this->getFiles(),
            'title' => $this->getTitle(),
            'max_files' => $this->getMaxFiles(),
            'post_max_size' => $this->getPostMaxSizeBytes(),
            'drop_zone' => $this->getDropZone(),
            'use_upload_camera' => $this->getUseUploadCamera(),
            'show_upload_image' => $this->getShowUploadImage(),
            'display_progress' => $this->getDisplayProgress(),
        ]);

        return $template->fetch();
    }

    public function useAjax()
    {
        return isset($this->_use_ajax) && $this->_use_ajax;
    }

    public function setUseUploadCamera($use_upload_camera)
    {
        $this->use_upload_camera = $use_upload_camera;

        return $this;
    }

    public function getUseUploadCamera()
    {
        return $this->use_upload_camera;
    }

    public function setShowUploadImage($show_upload_image)
    {
        $this->show_upload_image = $show_upload_image;

        return $this;
    }

    public function getShowUploadImage()
    {
        return $this->show_upload_image;
    }

    public function setDisplayProgress($display_progress)
    {
        $this->display_progress = $display_progress;

        return $this;
    }

    public function getDisplayProgress()
    {
        return $this->display_progress;
    }
}
