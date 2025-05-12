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

{if $type === 'price'}
    <span class="from_price from_price_{$product->id|escape:'htmlall':'UTF-8'}">{l s='From' mod='configurator'}</span>

    <script type="text/javascript">
		// For product listing ... No hooks to overriding button :(
		productPriceBlockHandler.processSetHtmlLinkToConfigurator({
			'link': '{$configurator_link|escape:'htmlall':'UTF-8'}',
			'l_configure': '{l s='Calculate price' mod='configurator'}',
			'id_product': '{$product->id|escape:'htmlall':'UTF-8'}'
		});
    </script>
{/if}
