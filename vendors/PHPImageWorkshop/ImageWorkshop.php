<?php
if (!defined('_PS_VERSION_')) {
    exit;
}

require_once __DIR__ . '/Core/ImageWorkshopLayer.php';
require_once __DIR__ . '/Exception/ImageWorkshopException.php';

/**
 * ImageWorkshop class
 *
 * Use this class as a factory to initialize ImageWorkshop layers
 *
 * @see http://phpimageworkshop.com
 *
 * @author Sybio (Clément Guillemain / @Sybio01)
 * @license http://en.wikipedia.org/wiki/MIT_License
 * @copyright Clément Guillemain
 */
class ImageWorkshop
{
    /**
     * @var int
     */
    public const ERROR_NOT_AN_IMAGE_FILE = 1;

    /**
     * @var int
     */
    public const ERROR_IMAGE_NOT_FOUND = 2;

    /**
     * @var int
     */
    public const ERROR_NOT_READABLE_FILE = 3;

    /**
     * @var int
     */
    public const ERROR_CREATE_IMAGE_FROM_STRING = 4;

    /**
     * Initialize a layer from a given image path
     *
     * From an upload form, you can give the "tmp_name" path
     *
     * @param string $path
     * @param bool $fixOrientation
     *
     * @return ImageWorkshopLayer
     */
    public static function initFromPath($path, $fixOrientation = false)
    {
        if (false === filter_var($path, FILTER_VALIDATE_URL) && !file_exists($path)) {
            throw new ImageWorkshopException(sprintf('File "%s" not exists.', $path), static::ERROR_IMAGE_NOT_FOUND);
        }

        if (false === ($imageSizeInfos = @getimagesize($path))) {
            throw new ImageWorkshopException('Can\'t open the file at "' . $path . '" : file is not readable, did you check permissions (755 / 777) ?', static::ERROR_NOT_READABLE_FILE);
        }

        $mimeContentType = explode('/', $imageSizeInfos['mime']);
        if (!$mimeContentType || !isset($mimeContentType[1])) {
            throw new ImageWorkshopException('Not an image file (jpeg/png/gif) at "' . $path . '"', static::ERROR_NOT_AN_IMAGE_FILE);
        }

        $mimeContentType = $mimeContentType[1];
        $exif = [];

        switch ($mimeContentType) {
            case 'jpeg':
                $image = imagecreatefromjpeg($path);
                if (false === ($exif = @read_exif_data($path))) {
                    $exif = [];
                }
                break;

            case 'gif':
                $image = imagecreatefromgif($path);
                break;

            case 'png':
                $image = imagecreatefrompng($path);
                break;

            default:
                throw new ImageWorkshopException('Not an image file (jpeg/png/gif) at "' . $path . '"', static::ERROR_NOT_AN_IMAGE_FILE);
                break;
        }

        if (false === $image) {
            throw new ImageWorkshopException('Unable to create image with file found at "' . $path . '"');
        }

        $layer = new ImageWorkshopLayer($image, $exif);

        if ($fixOrientation) {
            $layer->fixOrientation();
        }

        return $layer;
    }

    /**
     * Initialize a text layer
     *
     * @param string $text
     * @param string $fontPath
     * @param int $fontSize
     * @param string $fontColor
     * @param int $textRotation
     * @param int $backgroundColor
     *
     * @return ImageWorkshopLayer
     */
    public static function initTextLayer(
        $text,
        $fontPath,
        $fontSize = 13,
        $fontColor = 'ffffff',
        $textRotation = 0,
        $backgroundColor = null
    ) {
        $textDimensions = ImageWorkshopLib::getTextBoxDimension($fontSize, $textRotation, $fontPath, $text);

        $layer = static::initVirginLayer($textDimensions['width'], $textDimensions['height'], $backgroundColor);
        $layer->write($text, $fontPath, $fontSize, $fontColor, $textDimensions['left'], $textDimensions['top'],
            $textRotation);

        return $layer;
    }

    /**
     * Initialize a new virgin layer
     *
     * @param int $width
     * @param int $height
     * @param string $backgroundColor
     *
     * @return ImageWorkshopLayer
     */
    public static function initVirginLayer($width = 100, $height = 100, $backgroundColor = null)
    {
        $opacity = 0;

        if (null === $backgroundColor || $backgroundColor == 'transparent') {
            $opacity = 127;
            $backgroundColor = 'ffffff';
        }

        return new ImageWorkshopLayer(ImageWorkshopLib::generateImage($width, $height, $backgroundColor, $opacity));
    }

    /**
     * Initialize a layer from a resource image var
     *
     * @param resource $image
     *
     * @return ImageWorkshopLayer
     */
    public static function initFromResourceVar($image)
    {
        return new ImageWorkshopLayer($image);
    }

    /**
     * Initialize a layer from a string (obtains with file_get_contents, cURL...)
     *
     * This not recommanded to initialize JPEG string with this method, GD displays bugs !
     *
     * @param string $imageString
     *
     * @return ImageWorkshopLayer
     */
    public static function initFromString($imageString)
    {
        if (!$image = @imagecreatefromstring($imageString)) {
            throw new ImageWorkshopException('Can\'t generate an image from the given string.', static::ERROR_CREATE_IMAGE_FROM_STRING);
        }

        return new ImageWorkshopLayer($image);
    }
}
