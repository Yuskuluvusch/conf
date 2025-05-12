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

<a href="{$href|escape:'html':'UTF-8'}" title="{$action|escape:'html':'UTF-8'}" class="default {if isset($disabled) && $disabled}link-disabled{/if}"{if isset($name)} name="{$name|escape:'html':'UTF-8'}"{/if}>
	<i class="icon-asterisk"></i> {$action|escape:'html':'UTF-8'}
</a>
