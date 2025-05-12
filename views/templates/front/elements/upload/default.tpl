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

{if isset($step)}
	{$step->getUploaderTemplate(
		Context::getContext()->link->getProductLink($productObject)|cat:'?ajax=1&action=upload&step='|cat:$step->id|cat:'&configurator_update='|cat:$configuratorCartDetail->id,
		$configuratorCartDetail->getAttachments($step->id|intval)
	) nofilter} {* HTML CONTENT NO ESCAPE NEEDED *}
{/if}
