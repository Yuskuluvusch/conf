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
*   Create an input with min max constraints
*   Parameters :
*       $step       Same as in dispatcher
*       $option  Current element's option
*       $dimension  
*       $min        Input's minimum value   (int)
*       $max        Input's maximum value   (int)
*
*}

<div id="step_option_{$step->id|escape:'htmlall':'UTF-8'}_{$option->id|escape:'htmlall':'UTF-8'}"
            class="option_input option_group col-md-6 form-group" {*style="display:none;"*}>
        <div class="input-group"> 
                {include file='./input_core.tpl' dimension="{$dimension}" min=$min max=$max}
        </div>
        {assign var='min' value=($option->min_value)?$option->min_value:$min}
        {assign var='max' value=($option->max_value)?$option->max_value:$max}
        {if $min || $max}
                <small>
                        {l s='Available values:' mod='configurator'}
                        {if $min && $max}
                                {$min|escape:'htmlall':'UTF-8'}{$step->input_suffix|escape:'htmlall':'UTF-8'} - {$max|escape:'htmlall':'UTF-8'}{$step->input_suffix|escape:'htmlall':'UTF-8'}
                        {else if $min}
                                > {$min|escape:'htmlall':'UTF-8'}{$step->input_suffix|escape:'htmlall':'UTF-8'}
                        {else if $max}
                                < {$max|escape:'htmlall':'UTF-8'}{$step->input_suffix|escape:'htmlall':'UTF-8'}
                        {/if}
                </small>
        {/if}
</div>

