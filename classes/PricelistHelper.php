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

if (!defined('_CAN_LOAD_FILES_')) {
    exit;
}

if (!class_exists('PricelistHelper')) {
    class PricelistHelper
    {
        public const ONE_DIMENSION = 1;
        public const TWO_DIMENSION = 2;

        private $price_list = [];

        protected $dimension = self::ONE_DIMENSION;
        protected static $mime_types = [
            'csv' => [
                'application/csv',
                'application/vnd.ms-excel',
                'text/plain',
                'text/csv',
                'application/octet-stream',
                'text/tsv',
                'text/comma-separated-values',
            ],
        ];

        public function getPricelist()
        {
            return $this->price_list;
        }

        public function setPricelist($pricelist)
        {
            $this->price_list = $pricelist;

            // Mise à jour de la dimension de la grille tarifaire
            $this->dimension = self::ONE_DIMENSION;
            foreach ($pricelist as $value) {
                if (is_array($value)) {
                    $this->dimension = self::TWO_DIMENSION;
                    break;
                }
            }
        }

        public function getDimension()
        {
            return $this->dimension;
        }

        public function load($filevar)
        {
            /*
             * Avoid problem of import CSV
             */
            @ini_set('auto_detect_line_endings', true);
            if (isset($filevar['name'])
                && !empty($filevar['name'])
                && !empty($filevar['tmp_name'])
                && in_array($filevar['type'], self::$mime_types['csv'])
            ) {
                $file = fopen($filevar['tmp_name'], 'r');
                $price_list = [];
                $i = 0;
                $cols = [];
                while (($data_line = fgetcsv($file, 0, ';')) !== false) {
                    $row = 0;
                    foreach ($data_line as $k => $cell_value) {
                        $cell_value = str_replace(',', '.', $cell_value);
                        if ($i === 0 && $k > 0) {
                            $cols[] = $cell_value;
                        } elseif ($i > 0) {
                            if ($k === 0) {
                                $row = $cell_value;
                            } else {
                                $price_list[$row][$cols[$k - 1]] = (!is_numeric($cell_value) || $cell_value == 0)
                                    ? null
                                    : (float) $cell_value;
                            }
                        }
                    }
                    ++$i;
                }
                fclose($file);
                // Si la première clé n'est pas un nombre
                // nous pouvons considérer que nous sommes sur un tableau à 1 dimension
                if (!is_numeric(key($price_list))) {
                    $price_list = $price_list[key($price_list)];
                    $this->dimension = self::ONE_DIMENSION;
                } else {
                    $this->dimension = self::TWO_DIMENSION;
                }
                $this->price_list = $price_list;

                return true;
            }

            return false;
        }

        //
        // WARNING: Duplicate with get Value for price list impact with option
        // Should be refactored !
        //
        public function getValueStrict($x, $y = '')
        {
            $found_value = 0;
            $dim = self::ONE_DIMENSION;
            // Return value in price list
            if (!empty($x) || !empty($y)) {
                $real_x = false;
                $real_y = false;
                foreach ($this->price_list as $row_key => $row) {
                    if ($row_key == $x) {
                        if (!empty($x)) {
                            $real_x = $row_key;
                        }
                        // if $row has values, we are on 2D pricelist
                        if (is_array($row)) {
                            $dim = self::TWO_DIMENSION;
                            foreach (array_keys($row) as $col_key) {
                                if ($col_key == $y) {
                                    if (!empty($y)) {
                                        $real_y = $col_key;
                                    }
                                    break 2;
                                }
                            }
                        }
                        break;
                    }
                }

                if ($dim === self::ONE_DIMENSION && $real_x !== false) {
                    $found_value = $this->price_list[$real_x];
                } elseif ($dim === self::TWO_DIMENSION && $real_x !== false && $real_y !== false) {
                    $found_value = $this->price_list[$real_x][$real_y];
                } else {
                    // Value not found
                    return null;
                }
            }

            return $found_value;
        }

        /**
         * @todo: Réécriture complète à opérer pas propre
         *
         * @param type $x
         * @param type $y
         *
         * @return type
         */
        public function getValue($x, $y = '')
        {
            $found_value = 0;
            $dim = self::ONE_DIMENSION;
            // Return value in price list
            if (!empty($x) || !empty($y)) {
                $real_x = false;
                $real_y = false;
                foreach ($this->price_list as $row_key => $row) {
                    if ($row_key == $x) {
                        if (!empty($x)) {
                            $real_x = $row_key;
                        }
                        // if $row has values, we are on 2D pricelist
                        if (is_array($row) && count($row) > 1) {
                            $dim = self::TWO_DIMENSION;
                            foreach (array_keys($row) as $col_key) {
                                if ($col_key == $y) {
                                    if (!empty($y)) {
                                        $real_y = $col_key;
                                    }
                                    break 2;
                                }
                            }
                        }
                        break;
                    }
                }

                // if we didn't find both x and y, looking for it again
                // but with less restrictions
                if (!($real_x && $real_y)) {
                    foreach ($this->price_list as $row_key => $row) {
                        if ($row_key == $x || $row_key > $x) {
                            if (!empty($x)) {
                                $real_x = $row_key;
                            }
                            // if $row has values, we are on 2D pricelist
                            if (is_array($row) && count($row) > 1) {
                                $dim = self::TWO_DIMENSION;
                                foreach (array_keys($row) as $col_key) {
                                    if ($col_key == $y || $col_key > $y) {
                                        if (!empty($y)) {
                                            $real_y = $col_key;
                                        }
                                        break 2;
                                    }
                                }
                            }
                            break;
                        }
                    }
                }

                if ($dim === self::ONE_DIMENSION && $real_x !== false) {
                    if (is_array($this->price_list[$real_x])) {
                        $found_value = reset($this->price_list[$real_x]);
                    } else {
                        $found_value = $this->price_list[$real_x];
                    }
                } elseif ($dim === self::TWO_DIMENSION && $real_x !== false && $real_y !== false) {
                    $found_value = $this->price_list[$real_x][$real_y];
                } else {
                    // Value not found
                    return null;
                }
            }

            if ($found_value == 0) {
                return null;
            }

            return $found_value;
        }

        public function getMinMax($dimension = self::ONE_DIMENSION)
        {
            $min = -1;
            $max = -1;
            if (!empty($this->price_list)) {
                $size = count($this->price_list);
                $k = 0;
                foreach ($this->price_list as $row_key => $row) {
                    switch ($dimension) {
                        case self::ONE_DIMENSION:
                            $min = $k === 0 ? $row_key : $min;
                            $max = $k === $size - 1 ? $row_key : $max;
                            ++$k;
                            break;
                        case self::TWO_DIMENSION:
                            $size = count($row);
                            foreach (array_keys($row) as $col_key) {
                                $min = $k === 0 ? $col_key : $min;
                                $max = $k === $size - 1 ? $col_key : $max;
                                ++$k;
                            }
                            break;
                    }
                }
            }

            return ['min' => $min, 'max' => $max];
        }
    }
}
