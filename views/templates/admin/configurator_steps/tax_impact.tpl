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

{assign var=value value=$option->id_tax_rules_group_product}

<div id="tax_impact_{$option->id|escape:'htmlall':'UTF-8'}" class="price_impact">
    <div class="form-group">
        <label class='col-lg-12'>{l s='Tax impact for :' mod='configurator'} {$option->option.name|escape:'htmlall':'UTF-8'}</label>
    </div>
    <hr />

    <div class="form-group">
        <label class="control-label col-lg-4 required"
               for="select_taximpact_{$id|escape:'htmlall':'UTF-8'}"
        >
            {l s='Calculation method' mod='configurator'}
        </label>
        <div class="col-lg-8">
            <select id="select_taximpact_{$id|escape:'htmlall':'UTF-8'}"
                    name="select_taximpact_{$id|escape:'htmlall':'UTF-8'}"
                    class='select_taximpact chosen'
                    {if $configurator_step->type=="products"}disabled{/if}
            >
                {foreach $tax_impact_types as $tax}
                    <option value="{$tax.id_tax_rules_group|escape:'htmlall':'UTF-8'}"
                            {if $value eq $tax.id_tax_rules_group}selected='selected'{/if}
                    >
                        {$tax.name|escape:'htmlall':'UTF-8'}
                    </option>
                {/foreach}
            </select>
        </div>
    </div>
	
</div>
