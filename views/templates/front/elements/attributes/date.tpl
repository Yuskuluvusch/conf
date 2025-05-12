{*
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
 *
 *}

<div id="step_option_{$step->id|escape:'htmlall':'UTF-8'}_{$option->id|escape:'htmlall':'UTF-8'}"
     class="option_input option_group col-md-12 form-group" style="display:none;">
    
    <div class="input-group">
        <span class="input-group-addon">{$option->option.name|escape:'html':'UTF-8'} : </span>
    
        <input type="text"
                class="form-control grey" 
                data-step='{$step->id|escape:'htmlall':'UTF-8'}'
                data-option='{$option->id|escape:'htmlall':'UTF-8'}'
                data-force="{$option->force_value|escape:'htmlall':'UTF-8'}"
                data-format="{$format_date|escape:'htmlall':'UTF-8'}"
                id="option_{$step->id|escape:'htmlall':'UTF-8'}_{$option->id|escape:'htmlall':'UTF-8'}"
                placeholder="{$format_date|escape:'htmlall':'UTF-8'}"
                data-type="datePicker"
                value=""
                >
    </div> 
</div>
