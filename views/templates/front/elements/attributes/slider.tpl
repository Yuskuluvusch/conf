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

{*
*   Precondition: $step->price_list eq ''
*   Generate input's HTML for all options
*   If no constraints are given, generates a simple input.
*   If constraints (dimension, min and max) are given, adds them in input's parameters
*
*   Parameters :
*       $step       Same as in dispatcher
*       
*}

<div id="step_option_{$step->id|escape:'htmlall':'UTF-8'}_{$option->id|escape:'htmlall':'UTF-8'}"
     class="option_input option_group col-md-12 form-group" style="display:none;">
    <div class="step_option_name">{$option->option.name|escape:'html':'UTF-8'} :
        {if !empty($option->content[$lang_id])}
                {include file='../info.tpl' 
                         title=$option->option.name
                         content=$option->content[$lang_id]}
        {/if}
    </div>
    <div class="input-group">
        
        <div 
            {* If dimension, min and max are provided, add constraints*}
            {if isset($dimension) && isset($min) && isset($max)}
                data-dimension="1"
                data-min="{$min|escape:'htmlall':'UTF-8'}" 
                data-max="{$max|escape:'htmlall':'UTF-8'}"
            {/if}
                {if $option->min_value != ""}
                data-min="{$option->min_value|escape:'htmlall':'UTF-8'}"
            {/if}
                {if $option->max_value != ""}
                data-max="{$option->max_value|escape:'htmlall':'UTF-8'}"
            {/if}
            data-step='{$step->id|escape:'htmlall':'UTF-8'}' 
            data-option='{$option->id|escape:'htmlall':'UTF-8'}'
            data-force="{$option->force_value|escape:'htmlall':'UTF-8'}"
            id="option_{$step->id|escape:'htmlall':'UTF-8'}_{$option->id|escape:'htmlall':'UTF-8'}"
            data-type="slider"
            data-slider-step="{$option->slider_step|escape:'htmlall':'UTF-8'}"
            value="">
        </div>
            
    </div>
            
    <div id="slider_information_option_{$step->id|escape:'htmlall':'UTF-8'}_{$option->id|escape:'htmlall':'UTF-8'}">
        Votre valeur: <span class="value">0</span>&nbsp;
        {if $step->input_suffix neq ''}
            {$step->input_suffix|escape:'htmlall':'UTF-8'}
        {/if}
    </div>

    {if $option->min_value || $option->max_value}
        <small>
            {l s='Available values:' mod='configurator'}
            {if $option->min_value && $option->max_value}
                {$option->min_value|escape:'htmlall':'UTF-8'}{$step->input_suffix|escape:'htmlall':'UTF-8'} - {$option->max_value|escape:'htmlall':'UTF-8'}{$step->input_suffix|escape:'htmlall':'UTF-8'}
            {else if $option->min_value}
                > {$option->min_value|escape:'htmlall':'UTF-8'}{$step->input_suffix|escape:'htmlall':'UTF-8'}
            {else if $option->max_value}
                < {$option->max_value|escape:'htmlall':'UTF-8'}{$step->input_suffix|escape:'htmlall':'UTF-8'}
            {/if}
        </small>
    {/if}

</div>
