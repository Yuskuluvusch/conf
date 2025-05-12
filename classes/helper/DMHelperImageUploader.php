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

require_once dirname(__FILE__) . '/DMHelperUploader.php';

class DMHelperImageUploader extends DMHelperUploader
{
    public function getMaxSize()
    {
        return (int) Tools::getMaxUploadSize();
    }

    public function getSavePath()
    {
        return $this->_normalizeDirectory(_PS_TMP_IMG_DIR_);
    }

    public function getFilePath($file_name = null)
    {
        // Force file path
        return tempnam($this->getSavePath(), $this->getUniqueFileName());
    }

    protected function validate(&$file)
    {
        $file['error'] = $this->checkUploadError($file['error']);

        $post_max_size = Tools::convertBytes(ini_get('post_max_size'));

        $upload_max_filesize = Tools::convertBytes(ini_get('upload_max_filesize'));

        if ($post_max_size && ($this->_getServerVars('CONTENT_LENGTH') > $post_max_size)) {
            $file['error'] = Tools::displayError(
                'The uploaded file exceeds the post_max_size directive in php.ini'
            );

            return false;
        }

        if ($upload_max_filesize && ($this->_getServerVars('CONTENT_LENGTH') > $upload_max_filesize)) {
            $file['error'] = Tools::displayError(
                'The uploaded file exceeds the upload_max_filesize directive in php.ini'
            );

            return false;
        }

        if ($error = ImageManager::validateUpload(
            $file,
            Tools::getMaxUploadSize($this->getMaxSize()),
            $this->getAcceptTypes()
        )) {
            $file['error'] = $error;

            return false;
        }

        if ($file['size'] > $this->getMaxSize()) {
            $file['error'] = sprintf(
                Tools::displayError('File (size : %1s) is too big (max : %2s)'),
                $file['size'],
                $this->getMaxSize()
            );

            return false;
        }

        return true;
    }
}
