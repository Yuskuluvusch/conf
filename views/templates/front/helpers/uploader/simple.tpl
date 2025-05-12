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

{if isset($max_files) && $files|count >= $max_files}
<div class="row">
	<div class="alert alert-warning">{l s='You have reached the limit (%s) of files to upload, please remove files to continue uploading' mod='configurator' sprintf=$max_files}</div>
</div>
{else}
<div class="form-group">
	<input id="{$id|escape:'html':'UTF-8'}" type="file" name="{$name|escape:'html':'UTF-8'}{if isset ($multiple) && $multiple}[]{/if}"{if isset($multiple) && $multiple} multiple="multiple"{/if} />
</div>
<script type="text/javascript">
{if isset($multiple) && isset($max_files)}
	var {$id|escape:'html':'UTF-8'}_max_files = {$max_files - $files|count};
{/if}

	$(document).ready(function(){
		$('#{$id|escape:'html':'UTF-8'}-selectbutton').click(function(e) {
			$('#{$id|escape:'html':'UTF-8'}').trigger('click');
		});

		$('#{$id|escape:'html':'UTF-8'}-name').click(function(e) {
			$('#{$id|escape:'html':'UTF-8'}').trigger('click');
		});

		$('#{$id|escape:'html':'UTF-8'}-name').on('dragenter', function(e) {
			e.stopPropagation();
			e.preventDefault();
		});

		$('#{$id|escape:'html':'UTF-8'}-name').on('dragover', function(e) {
			e.stopPropagation();
			e.preventDefault();
		});

		$('#{$id|escape:'html':'UTF-8'}-name').on('drop', function(e) {
			e.preventDefault();
			var files = e.originalEvent.dataTransfer.files;
			$('#{$id|escape:'html':'UTF-8'}')[0].files = files;
			$(this).val(files[0].name);
		});

		$('#{$id|escape:'html':'UTF-8'}').change(function(e) {
			if ($(this)[0].files !== undefined)
			{
				var files = $(this)[0].files;
				var name  = '';

				$.each(files, function(index, value) {
					name += value.name+', ';
				});

				$('#{$id|escape:'html':'UTF-8'}-name').val(name.slice(0, -2));
			}
			else // Internet Explorer 9 Compatibility
			{
				var name = $(this).val().split(/[\\/]/);
				$('#{$id|escape:'html':'UTF-8'}-name').val(name[name.length-1]);
			}
		});

		if (typeof {$id|escape:'html':'UTF-8'}_max_files !== 'undefined')
		{
			$('#{$id|escape:'html':'UTF-8'}').closest('form').on('submit', function(e) {
				if ($('#{$id|escape:'html':'UTF-8'}')[0].files.length > {$id|escape:'html':'UTF-8'}_max_files) {
					e.preventDefault();
					alert('{l s='You can upload a maximum of %s files'|sprintf:$max_files mod='configurator'}');
				}
			});
		}
	});
</script>
{/if}
