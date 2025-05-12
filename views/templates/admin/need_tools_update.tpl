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

{if $need_tools_update}
    <div class="alert alert-warning">
        <a href='{$configurator_tools_link|escape:'htmlall':'UTF-8'}'>
            {l s='You need to update the module in the Configurators tools page' mod='configurator'} <i class='icon-external-link'></i>
        </a>
    </div>
{else}
    <div class="alert alert-info">
        <a href='{$configurator_tools_link|escape:'htmlall':'UTF-8'}'>
            {l s='Go to tools page' mod='configurator'} <i class='icon-external-link'></i>
        </a>
    </div>
{/if}
