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

{* TODO check line 34 htmlentitiesUTF8 *}
{foreach from=$languages item=language}
	{if $languages|count > 1}
		<div class="translatable-field row lang-{$language.id_lang}">
			<div class="col-lg-9">
	{/if}

	{if isset($maxchar)}
		<div class="input-group">
			<span id="{$input_name}_{$language.id_lang}_counter" class="input-group-addon">
				<span class="text-count-down">{$maxchar}</span>
			</span>
	{/if}

	<input type="text"
		   id="{$input_name}_{$language.id_lang}"
		   class="form-control {if isset($input_class)}{$input_class} {/if}"
		   name="{$input_name}_{$language.id_lang}"
		   value="{if isset($input_value[$language.id_lang])}{$input_value[$language.id_lang]}{/if}"
		   onkeyup="if (isArrowKey(event)) return ;updateFriendlyURL();"
		   onblur="updateLinkRewrite();"
		   {if isset($required)} required="required"{/if}
		   {if isset($maxchar)} data-maxchar="{$maxchar}"{/if}
		   {if isset($maxlength)} maxlength="{$maxlength}"{/if}
	>

	{if isset($maxchar)}
		</div>
	{/if}
	{if $languages|count > 1}
			</div>
			<div class="col-lg-2">
				<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" tabindex="-1">
					{$language.iso_code}
					<span class="caret"></span>
				</button>
				<ul class="dropdown-menu">
					{foreach from=$languages item=language}
						<li>
							<a href="javascript:tabs_manager.allow_hide_other_languages = false;hideOtherLanguage({$language.id_lang});">{$language.name}</a>
						</li>
					{/foreach}
				</ul>
			</div>
		</div>
	{/if}
{/foreach}

{if isset($maxchar)}
	<script type="text/javascript">
		$(document).ready(function() {
			{foreach from=$languages item=language}
				countDown($("#{$input_name}_{$language.id_lang}"), $("#{$input_name}_{$language.id_lang}_counter"));
			{/foreach}
		});
	</script>
{/if}
