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

{foreach from=$languages item=language}
	{if $languages|count > 1}
		<div class="translatable-field row lang-{$language.id_lang}">
			<div class="col-lg-9">
	{/if}
	{if isset($maxchar) && $maxchar}
				<div class="input-group">
					<span id="{if isset($input_id)}{$input_id}_{$language.id_lang}{else}{$input_name}_{$language.id_lang}{/if}_counter" class="input-group-addon">
						<span class="text-count-down">{$maxchar|intval}</span>
					</span>
	{/if}
					<textarea id="{$input_name}_{$language.id_lang}" name="{$input_name}_{$language.id_lang}" class="{if isset($class)}{$class}{else}textarea-autosize{/if}"{if isset($maxlength) && $maxlength} maxlength="{$maxlength|intval}"{/if}{if isset($maxchar) && $maxchar} data-maxchar="{$maxchar|intval}"{/if}>{if isset($input_value[$language.id_lang])}{$input_value[$language.id_lang]|htmlentitiesUTF8}{/if}</textarea>
					<span class="counter" data-max="{if isset($max)}{$max|intval}{/if}{if isset($maxlength)}{$maxlength|intval}{/if}{if !isset($max) && !isset($maxlength)}none{/if}"></span>
			{if isset($maxchar) && $maxchar}
				</div>
			{/if}
	{if $languages|count > 1}
			</div>
			<div class="col-lg-2">
				<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
					{$language.iso_code}
					<span class="caret"></span>
				</button>
				<ul class="dropdown-menu">
					{foreach from=$languages item=language}
					<li><a href="javascript:tabs_manager.allow_hide_other_languages = false;hideOtherLanguage({$language.id_lang});">{$language.name}</a></li>
					{/foreach}
				</ul>
			</div>
		</div>
	{/if}
{/foreach}
<script type="text/javascript">
	{if isset($maxchar) && $maxchar}
		$(document).ready(function(){
		{foreach from=$languages item=language}
			countDown($("#{$input_name}_{$language.id_lang}"), $("#{$input_name}_{$language.id_lang}_counter"));
		{/foreach}
		});
	{/if}
	$(".textarea-autosize").autosize();
</script>
