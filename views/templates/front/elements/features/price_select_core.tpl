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
*   Create a HTML select element using $options as values
*   Parameters :
*       $step       Same as in dispatcher
*       $option  Current element's option
*       $dimension  Data's dimension (1 equals first dimension, 2 second)
*       $options    This array's keys will be used as key and value for select element
*}

<div id="step_option_{$step->id|escape:'htmlall':'UTF-8'}_{$option->id|escape:'htmlall':'UTF-8'}"
        class="option_input option_group col-md-6 form-group" style="display:none;">
        <div class="input-group">
                <span class="input-group-addon">{$option->option.name|escape:'html':'UTF-8'} : </span>

                <select
                        data-dimension="{$dimension}"
                        data-step='{$step->id|escape:'htmlall':'UTF-8'}' 
                        data-option='{$option->id|escape:'htmlall':'UTF-8'}'
                        id="option_{$step->id|escape:'htmlall':'UTF-8'}_{$option->id|escape:'htmlall':'UTF-8'}"
                        class="form-control grey" >

                        <option value="">{l s='Choose in the dropdown' mod='configurator'}</option>
                        {foreach $options as $x => $price_col}
                                <option value="{$x|escape:'htmlall':'UTF-8'}">{$x|escape:'htmlall':'UTF-8'}</option>
                        {/foreach}
                </select>

                {if $step->input_suffix neq ''}
                        <span class="input-group-addon">
                                {$step->input_suffix|escape:'htmlall':'UTF-8'}
                        </span>
                {/if}
                {if !empty($option->content[$lang_id])}
                        {include file='../info.tpl' 
                                 title=$option->option.name
                                 content=$option->content[$lang_id]}
                {/if}
                {include file="../impact_price.tpl"}
        </div>
</div>
