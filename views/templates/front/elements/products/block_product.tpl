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

{foreach $step->options as $option}
    {if $option}
        <div id="step_option_{$step->id|escape:'htmlall':'UTF-8'}_{$option->id|escape:'htmlall':'UTF-8'}"
             class="option_block option_group custom {if $option->disabled}disabled{/if}"
             style="display:none;"
                {if !empty($option->content[$lang_id])}
                    data-toggle="popover"
                    title="{$option->option.name|escape:'html':'UTF-8'}"
                    data-content="{$option->content[$lang_id]|escape:'htmlall':'UTF-8'} "
                {/if}
        >

            <div class='option_block_content'>
                <span class="configurator-zoom"><i class="icon-zoom-in"></i></span>
                <div class="option_img">
                    {if isset($option->layers) and count($option->layers) > 0}
                        {foreach $option->layers as $layer}
                            <img src="{$layer->layer_path}">
                        {/foreach}
                    {else}
                        {if $option->ipa}
                            {assign var='image' value=Image::getBestImageAttribute(Context::getContext()->shop->id, $lang_id, $option->id_option, $option->ipa)}
                        {/if}
                        {if !$option->ipa || !$image}
                        {assign var='image' value=Image::getCover($option->id_option)}
                        {/if}
                        <img class="img-responsive" alt="{$option->option.name|escape:'html':'UTF-8'}" src="{Context::getContext()->link->getImageLink($option->id_option, $image['id_image'], 'home_default')}" />
                        {if Configuration::get('DMUPACK_PRODUCT_CONTENT_DISPLAY')}
                            <a class="hidden" href="{Context::getContext()->link->getProductLink($option->id_option, null, null, null, null, null, $option->ipa, false, false, false, ['content_only' => 1])}"></a>
                        {/if}
                    {/if}
                </div>

                <input class="hidden"
                       data-step='{$step->id|escape:'htmlall':'UTF-8'}'
                       id="option_{$step->id|escape:'htmlall':'UTF-8'}_{$option->id|escape:'htmlall':'UTF-8'}"
                       type="{if $step->multiple}checkbox{else}radio{/if}" name="step[{$step->id|escape:'htmlall':'UTF-8'}][]"
                       value="{$option->id|escape:'htmlall':'UTF-8'}"
                />

                <span class="product-name">{$option->option.name|escape:'html':'UTF-8'}</span>
                {if !$step->use_qty}
                    {include file="../impact_price.tpl"}
                {/if}
            </div>

            {if $step->use_qty}
                {include file="../quantity.tpl"}
            {/if}

            {if $step->use_qty and !$step->display_total}
                {include file="../impact_price.tpl"}
            {/if}

            {if $step->display_total}
                {include file="../impact_total_price.tpl"}
            {/if}
        </div>
    {/if}
{/foreach}
<div class="clearfix">&nbsp;</div>

