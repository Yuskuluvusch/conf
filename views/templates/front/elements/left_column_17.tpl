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

{if $content_only}
    {$HOOK_CONFIGURATOR_DISPLAY_FRONT_PRODUCT_LEFT_COLUMN nofilter}{* HTML comment, no escape necessary *}
{else}
    <section class="page-content configurator-custom-left-column" id="content" data-configurator-view="2d">
        {$HOOK_CONFIGURATOR_DISPLAY_FRONT_PRODUCT_LEFT_COLUMN nofilter}{* HTML comment, no escape necessary *}
        <div class="configurator-product-cover">
            {block name='page_content'}
                {block name='product_flags'}
                    <ul class="product-flags">
                        {foreach from=$product.flags item=flag}
                            <li class="product-flag {$flag.type}">{$flag.label}</li>
                        {/foreach}
                    </ul>
                {/block}
                {block name='product_cover_thumbnails'}
                    {include file='catalog/_partials/product-cover-thumbnails.tpl'}
                {/block}
                <div class="scroll-box-arrows">
                    <i class="material-icons left">&#xE314;</i>
                    <i class="material-icons right">&#xE315;</i>
                </div>
            {/block}
        </div>
    </section>
{/if}