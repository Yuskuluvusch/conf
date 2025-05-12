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

<div class="row">
    <div class="col-md-12">
        <h2>{l s='Product configurator - Tabs' mod='configurator'}</h2>
    </div>
    <div class="col-md-12">
        <div class='form-group'>
            <label class="control-label col-lg-4" for="tab_type">
                {l s='Tab\'s type:' mod='configurator'}
                <span class="help-box" data-toggle="popover" data-content="{l s='Type of the tab' mod='configurator'}" data-original-title="" title=""></span>
            </label>
            <div class="col-lg-4">
                <select class="form-control" name="tab_type">
                    <option value="tab">{l s='Tabs' mod='configurator'}</option>
                    <option {if $configurator->tab_type === 'accordion'}selected{/if} value="accordion">{l s='Accordion' mod='configurator'}</option>
                </select>
            </div>
        </div>
        <div class='form-group'>
            <label class="control-label col-lg-4" for="tab_force_require_step">
                {l s='Force required steps :' mod='configurator'}
            </label>
            <div class="col-lg-4">
                <select class="form-control" name="tab_force_require_step">
                    <option value="0">{l s='No' mod='configurator'}</option>
                    <option {if $configurator->tab_force_require_step}selected{/if} value="1">{l s='Yes' mod='configurator'}</option>
                </select>
            </div>
        </div>
    </div>
    <div class="col-md-10">
        <div id='add_tab' class='form-group'>
            <input value="" class="form-control" type="hidden" id="id_configurator_step_tab" name="id_configurator_step_tab"/>
            <label class="control-label col-lg-4" for="tab_name_{$id_lang|escape:'htmlall':'UTF-8'}">
                {l s='Tab\'s name:' mod='configurator'}
                <span class="help-box" data-toggle="popover" data-content="{l s='Name of the tab' mod='configurator'}" data-original-title="" title=""></span>
            </label>
            <div class="col-lg-8 no-margin">
                {include 'module:configurator/views/templates/admin/configurator/helpers/form/input_text_lang.tpl'
                    languages=$languages
                    input_name='tab_name'
                }
            </div>
        </div>
    </div>
    <div class="col-md-2">
        <a href="javascript:void(0);" class="btn btn-primary pull-right btn_confirm_tab" data-process='adding'>
            <i class="process-icon-save"></i>
            {l s='Save tab' mod='configurator'}
        </a>
    </div>
</div>
<br><br>
<div class="row">
    <div class="col-md-12">
        <h2>{l s='Product configurator - Tabs list' mod='configurator'}<h2>
        <div class="form-group">
            <div class="col-lg-12" style="display: none;">
                <div id="alert-table-empty" class="alert alert-warning">
                    {l s='No tab available.' mod='configurator'}
                    <a href="javascript:void(0);">{l s='Add at least one tab to see one listed here.' mod='configurator'}</a>
                </div>
            </div>
            <div class="table-responsive" style="display: none;">
                <table id="configurator-tab-list" class="table table-bordered text-center">
                    <thead>
                        <tr>
                            <th class="text-center">{l s='ID' mod='configurator'}</th>
                            {foreach $languages as $language}
                                <th class="translatable-field text-center lang-{$language.id_lang}">{l s='Name' mod='configurator'}</th>
                            {/foreach}
                            <th class="text-center" width="200">{l s='Position' mod='configurator'}</th>
                            <th class="text-center" width="200">{l s='Action' mod='configurator'}</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script id="configurator_template_tab" type="text/x-handlebars-template">
    <tr data-id="{literal}{{ id }}{/literal}">
        <td>{literal}{{ id }}{/literal}</td>
        {foreach $languages as $language}
            <td class="translatable-field lang-{$language.id_lang}">{literal}{{ name_{/literal}{$language.id_lang}{literal} }}{/literal}</td>
        {/foreach}
        <td>
            <a href="javascript:void(0);" data-id="{literal}{{ id }}{/literal}" class="btn btn-primary-outline configurator-tab-list-btn-edit-position-down">
                <i class="material-icons">keyboard_arrow_down</i>
            </a>
            <a href="javascript:void(0);" data-id="{literal}{{ id }}{/literal}" class="btn btn-primary-outline configurator-tab-list-btn-edit-position-up">
                <i class="material-icons">keyboard_arrow_up</i>
            </a>
        </td>
        <td>
            <a href="javascript:void(0);" data-id="{literal}{{ id }}{/literal}" class="btn btn-primary-outline configurator-tab-list-btn-edit">
                <i class="material-icons">mode_edit</i>
            </a>
            <a href="javascript:void(0);" data-id="{literal}{{ id }}{/literal}" class="btn btn-primary-outline configurator-tab-list-btn-delete">
                <i class="material-icons">delete</i>
            </a>
        </td>
    </tr>
</script>

<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function(event) {
        CONFIGURATOR_PRODUCT_MANAGER.init({
            translation: {
                save: '{l s='Save' mod='configurator' js=1}',
                confirm_delete: '{l s='Do you want to delete this tab?' mod='configurator' js=1}'
            },
            admin_link: "{Context::getContext()->link->getAdminLink('AdminConfiguratorTabs')}",
            id_configurator: {$configurator->id|escape:'htmlall':'UTF-8'},
            tabs: {$tabs|json_encode},
            lang_list: {$languages_json} {* no filter needed *}

        });
    });
</script>
