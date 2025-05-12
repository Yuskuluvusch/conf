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

        <textarea
                data-step='{$step->id|escape:'htmlall':'UTF-8'}'
                data-option='{$option->id|escape:'htmlall':'UTF-8'}'
                data-force="{$option->force_value|escape:'htmlall':'UTF-8'}"
                id="option_{$step->id|escape:'htmlall':'UTF-8'}_{$option->id|escape:'htmlall':'UTF-8'}"
                class="form-control grey"
                value=""
            {* If dimension, min and max are provided, add constraints*}
                {if isset($dimension) && isset($min) && isset($max)}
                    data-dimension="{$dimension|escape:'htmlall':'UTF-8'}"
                    data-min="{$min|escape:'htmlall':'UTF-8'}"
                    minlength="{$min|escape:'htmlall':'UTF-8'}"
                    data-max="{$max|escape:'htmlall':'UTF-8'}"
                    maxlength="{$max|escape:'htmlall':'UTF-8'}"
                {/if}
                {if $option->min_value != ""}
                    data-min="{$option->min_value|escape:'htmlall':'UTF-8'}"
                    minlength="{$option->min_value|escape:'htmlall':'UTF-8'}"
                {/if}
                {if $option->max_value != ""}
                    data-max="{$option->max_value|escape:'htmlall':'UTF-8'}"
                    maxlength="{$option->max_value|escape:'htmlall':'UTF-8'}"
                {/if}
                {if $option->placeholder != ""}
                    placeholder="{$option->placeholder|escape:'htmlall':'UTF-8'}"
                {/if}
        ></textarea>

        {if $step->input_suffix neq ''}
            <span class="input-group-addon">
                {$step->input_suffix|escape:'htmlall':'UTF-8'}
            </span>
        {/if}
    </div>

    <div>
        <small class="label_min" style="display: {if $option->min_value}inline{else}none{/if}">
            > <span class="option_min_value">{$option->min_value|escape:'htmlall':'UTF-8'}</span> {l s='characters' mod='configurator'}
        </small>
        <div style="display: inline; float: right;">
            <small><span class="option_current_value">0</small>
            <small class="label_max" style="display: {if $option->max_value}inline{else}none{/if}">
                / <span class="option_max_value">{$option->max_value|escape:'htmlall':'UTF-8'}</span>
            </small>
            <small>{l s='characters' mod='configurator'}</small>
        </div>
    </div>

    {if !empty($option->content[$lang_id])}
        {include file='../info.tpl'
        title=$option->option.name
        content=$option->content[$lang_id]}
    {/if}

    {if $step->price_list eq ''}{include file="../impact_price.tpl"}{/if}
</div>
