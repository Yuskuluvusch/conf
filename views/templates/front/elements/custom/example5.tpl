{*
* 2007-2019 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author DMConcept <support@dmconcept.fr>
*  @copyright 2015 DMConcept
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

<div class="row">
        {if $step->options[0]}
                <div id="step_option_{$step->id|escape:'htmlall':'UTF-8'}_{$step->options[0]->id|escape:'htmlall':'UTF-8'}"
                     class="option_input option_group col-md-6 form-group" style="display:none;">
                        <div class="input-group">
                                {include file=/public_html/themes/warehouse/templates/_partials/form-fields.tpl option=$step->options[0] step=$step dimension="1"}
                        </div>
                </div>
        {/if}
        {if $step->options[1]}
                <div id="step_option_{$step->id|escape:'htmlall':'UTF-8'}_{$step->options[1]->id|escape:'htmlall':'UTF-8'}"
                     class="option_input option_group col-md-6 form-group" style="display:none;">
                        <div class="input-group">
                                {include file=/public_html/themes/warehouse/templates/_partials/form-fields.tpl option=$step->options[1] step=$step dimension="1"}
                        </div>
                </div>
        {/if}
</div>
<div class="row">
        {if $step->options[2]}
                <div id="step_option_{$step->id|escape:'htmlall':'UTF-8'}_{$step->options[2]->id|escape:'htmlall':'UTF-8'}"
                     class="option_input option_group col-md-6 form-group" style="display:none;">
                        <div class="input-group">
                                {include file=/public_html/themes/warehouse/templates/_partials/form-fields.tpl option=$step->options[2] step=$step dimension="1"}
                        </div>
                </div>
        {/if}
</div>
<div class="row">
        {if $step->options[3]}
                <div id="step_option_{$step->id|escape:'htmlall':'UTF-8'}_{$step->options[3]->id|escape:'htmlall':'UTF-8'}"
                     class="option_input option_group col-md-6 form-group" style="display:none;">
                        <div class="input-group">
                                {include file=/public_html/themes/warehouse/templates/_partials/form-fields.tpl option=$step->options[3] step=$step dimension="1"}
                        </div>
                </div>
        {/if}
</div>