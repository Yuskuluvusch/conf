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

{extends file="helpers/form/form.tpl"}

{block name="script"}
	{$smarty.block.parent}

	document.addEventListener("DOMContentLoaded", function(){
		$('#id_product').removeClass('fixed-width-xl');
		$('#id_product').css('width', '100%');
		$('#id_product').select2({
			placeholder: 'select',
			formatNoMatches: 'no match found',
			allowClear: true
		});
	});
{/block}
