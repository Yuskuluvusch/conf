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

<div class="modal-body">
        <table class="table"> 
                <thead> 
                        <tr> 
                                <th>{l s='Name' mod='configurator'}</th>
                                <th>{l s='Size' mod='configurator'}</th>
                                <th>{l s='Operations' mod='configurator'}</th>                                    
                        </tr> 
                </thead> 
                <tbody> 
                        <tr class="header-row" data-id="0">
                                <td><input class="form-control header-name" required type="text" placeholder="{l s='Header\'s name' mod='configurator'}"></td>
                                <td><input class="form-control header-size" required type="number" min="1" placeholder="{l s='Size' mod='configurator'}"></td>
                                <td>
                                        <button type="button" class="btn btn-danger header-delete-action">{l s='Delete' mod='configurator'}</button>
                                </td>
                        </tr>              
                </tbody>
        </table>
</div>

<form method="post" action="" class="form-horizontal" id="formula_form">
        <div class="modal-footer">
                <button data-dismiss="modal" class="btn btn-default header-cancel" data-dismiss="modal" type="button">Annuler</button>
                <button class="btn btn-primary header-add" type="submit">{l s='Add header' mod='configurator'}</button>
                <button class="btn btn-success header-save" type="submit">{l s='Save' mod='configurator'}</button>
        </div>
</form>

<script type="text/javascript">
        $(document).on('ready', function(){
            
                if (typeof languages === 'undefined') {
                    // means we are not in the appropriate page for price_list_header
                    return;
                }
            
                var dataSRC = '#header-group .translatable-field[style*="display: block"] input';
                if (languages.length === 1) {
                       dataSRC = '#header_names_1';
                }
                
                if ($(dataSRC).length === 0) {
                    // means there is no input link to header
                    // security measures
                    return;
                }
             

                var config = {
                        dataSRC: dataSRC,
                        selectorShow: '#btn-show-price-list-header',
                        selectorPanel: '#modal_configurator_header',
                        selectorAddHeader: '#modal_configurator_header .modal-footer .header-add',
                        selectorSaveHeader:'#modal_configurator_header .modal-footer .header-save',
                        row: '.header-row',
                        messageDeleteRow: '{l s='Are you sure ?' mod='configurator'}'
                };

                CONFIGURATOR.PriceListHeader.init(config);
        });
</script>
