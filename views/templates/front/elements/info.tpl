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

<span class="label label-info info{if $DISPLAY_TOOLTIP_FANCYBOX}-fb{/if}"
	  data-toggle="popover"
	  title="{$title|escape:'html':'UTF-8'}"
	  data-content="{$content|escape:'htmlall':'UTF-8'} ">{l s='INFO' mod='configurator'}
</span>
