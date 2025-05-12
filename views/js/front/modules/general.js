/**
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
 */

var CONFIGURATOR = CONFIGURATOR || {};
CONFIGURATOR.MODULES = CONFIGURATOR.MODULES || {};

/**
 * Handles general behaviour throughout the page. 
 * Contains: 
 *  - all methods to show hints (info label, textures etc)
 */
CONFIGURATOR.MODULES.General = function() {

    /**
     * Info label on steps and options
     */
    this.query_info_label = '.info';

    /**
     * Info label on steps and options but displayed in a
     * fancy box
     */
    this.query_info_label_fancy = '.info-fb';

    /**
     * Info on texture (colours)
     */
    this.query_info_texture = '#configurator_block .option_block';

    /**
     *  Zoom element that allows to display texture in a popup
     */
    this.query_configurator_zoom = '.configurator-zoom';

    /**
     *  Used to find image for zoom element
     */
    this.query_option_block = '.option_block';
    
    /**
     * Used for tabs
     */
    this.step_group_class = '.step_group';
    this.step_list_class = '.step_list';
    this.configurator_tab_page_class = '.configurator-tab-page';
    this.configurator_tabs_id = '#configurator-tabs';
    this.configurator_tabs_actions_class = '.configurator-tabs-actions';
    this.tab_action_previous_id = '#tab-action-previous';
    this.tab_action_next_id = '#tab-action-next';
    this.tab_action_add_cart_id = '#tab-action-add-to-cart';
    this.add_configurator_to_cart_id = '#add_configurator_to_cart';
    this.tab_action_next_preview = '#tab-action-next-preview';
    this.configurator_block = '#configurator_block';
    this.configurator_quantity = '#quantity-configurator';
    this.configurator_change_shared_step = '.configurator-change-shared-step';

    this.configurator_accordions_id = '#configurator-accordions';
    this.configurator_accordions_actions_class = '.configurator-accordions-actions';
    this.accordion_action_previous_class = '.accordion-action-previous';
    this.accordion_action_next_class = '.accordion-action-next';
    this.accordion_action_add_to_cart_class = '.accordion-action-add-to-cart';

    /**
     * Binds popover 'targets' element
     * @param {type} targets    Query
     */
    this.showPopOver = function(targets, delays) {
        var delay = {};
        if(delays) {
           delay = { 
                show: 100,
                hide: parseInt(delays)
           };
        }
        if (typeof popover_trigger === 'undefined') {
            var popover_trigger = 'hover';
        }
        $(targets).popover({
            html: true,
            placement: 'top',
            delay: delay,
            trigger: popover_trigger
        });
    };

    /**
     * Unbinds popover 'targets' element
     * @param {type} targets    Query
     */
    this.hidePopOver = function(targets) {
        $(targets).popover('destroy');
    };

    /**
     * Calls all methods 'showXXX'
     */
    this.eventAction = function() {
        this.nextAccordion();
        this.previousAccordion();
        this.nextTab();
        this.previousTab();
        this.addToCartTab();
        this.changeQuantity();
        this.changeSharedStep();

        $('#configurator_block').on('click', this.query_option_block, function(event) {
            if ($(this).hasClass('disabled')) {
                event.preventDefault();
                event.stopPropagation();
            }
        });
    };
    
    /**
     * Calls all methods 'showXXX'
     */
    this.showAll = function() {
        this.showTabs();
        this.showInfoLabel();
        this.showInfoLabelFancy();
        this.showInfoTexture();
        this.showZoomTexture();
    };

    /**
     * Calls all methods 'hideXXX'
     */
    this.hideAll = function() {
        this.hideTabs();
        this.hideInfoLabel();
        this.hideInfoLabelFancy();
        this.hideInfoTexture();
        this.hideZoomTexture();
    };

    /**
     * Binds popup for info label (steps and options)
     */
    this.showInfoLabel = function() {
        var delay = (typeof tooltip_display !== 'undefined') ? tooltip_display : false;
        this.showPopOver(this.query_info_label, delay);
    };

    /**
     * Unbinds popup for info label (steps and options)
     */
    this.hideInfoLabel = function() {
        this.hidePopOver(this.query_info_label, false);
    };

    /**
     * Binds fancy popup for info label (steps and options)
     */
    this.showInfoLabelFancy = function() {
        $(this.query_info_label_fancy).bind('click', this.showInfoLabelFancyClick);
    };

    /**
     * On click action for fancy labels
     */
    this.showInfoLabelFancyClick = function() {
        if (!!$.prototype.fancybox){
            $.fancybox.open([
            {
                'openEffect': 'elastic',
                'closeEffect': 'elastic',
                'type': 'inline',
                'autoScale': true,
                'minHeight': 30,
                'content': $(this).data('content')
            }]);
        }
    };

    /**
     * Unbinds fancy popup for info label (steps and options)
     */
    this.hideInfoLabelFancy = function() {
        $(this.query_info_label_fancy).unbind('click', this.showInfoLabelFancyClick);
    };

    /**
     * Binds for info textures
     */
    this.showInfoTexture = function() {
        var delay = (typeof tooltip_display !== 'undefined') ? tooltip_display : false;
        this.showPopOver(this.query_info_texture, delay);
    };

    /**
     * Unbinds for info textures
     */
    this.hideInfoTexture = function() {
        this.hidePopOver(this.query_info_texture);
    };

    /**
     * Binds fancy popup for custom textures
     */
    this.showZoomTexture = function() {
        // used in order to make a specific unbind in hideZoomTexture
        this.showZoomTextureC = this.showZoomTextureClick();
        $(this.query_configurator_zoom).bind('click', this.showZoomTextureC);
    };

    /**
     * On click action for custom textures
     */
    this.showZoomTextureClick = function() {
        var self = this;
        return function() {
            var img = $(this).closest(self.query_option_block).find('img');
            var link =$(this).closest(self.query_option_block).find('a.hidden');

            if (link.length) {
                if (!!$.prototype.fancybox){
                    $.fancybox.open([
                        {
                            'openEffect': 'elastic',
                            'closeEffect': 'elastic',
                            'autoScale': true,
                            'type': 'iframe',
                            'href': link.attr('href')
                        }]);
                }
            } else if (!!$.prototype.fancybox){
                $.fancybox.open([
                    {
                        'openEffect': 'elastic',
                        'closeEffect': 'elastic',
                        'autoScale': true,
                        'content': img.clone()
                    }]);
            }
        };
    };

    /**
     * Unbinds fancy popup for custom textures
     */
    this.hideZoomTexture = function() {
        $(this.query_configurator_zoom).unbind('click', this.showZoomTextureC);
    };

    this.nextAccordion = function() {
        var self = this;
        $(self.configurator_accordions_actions_class+' '+self.accordion_action_next_class).bind('click', function (event){
            var selected_accordion = $(self.configurator_accordions_id).find('.panel-collapse.in');
            var next_accordion = selected_accordion.parent().next().find('.configurator-tab-page');
            if(next_accordion.length > 0) {
                next_accordion.trigger('click');
            }
        });
        $(self.configurator_block).on('click', self.tab_action_next_preview, function (event){
            $(self.configurator_accordions_id+' .panel-collapse.in '+self.accordion_action_next_class).trigger('click');
        });

        $(self.configurator_accordions_id).on('shown.bs.collapse', function (event) {
            $(self.configurator_accordions_id).find('.accordion-opened').removeClass('accordion-opened');
            var target = $(event.target);
            target.parent().addClass('accordion-opened');
            if (target.parent().next().length > 0) {
                $(self.add_configurator_to_cart_id).hide();
                $(self.tab_action_next_preview).show();
            } else {
                $(self.add_configurator_to_cart_id).show();
                $(self.tab_action_next_preview).hide();
            }

            $('html, body').stop().animate({
                'scrollTop': target.parent().offset().top
            }, 900);
        });
    };

    this.previousAccordion = function() {
        var self = this;
        $(self.configurator_accordions_actions_class+' '+self.accordion_action_previous_class).bind('click', function (event){
            var selected_accordion = $(self.configurator_accordions_id).find('.panel-collapse.in');
            var previous_accordion = selected_accordion.parent().prev().find('.configurator-tab-page');
            if(previous_accordion.length > 0) {
                previous_accordion.trigger('click');
            }
        });
    };

    this.displayActionAccordion = function() {
        var self = this;
        var current = $(self.configurator_accordions_id+' .panel-collapse.in').parent();
        if (current.next().length > 0) {
            $(self.add_configurator_to_cart_id).hide();
            $(self.tab_action_next_preview).show();
        } else {
            $(self.add_configurator_to_cart_id).show();
            $(self.tab_action_next_preview).hide();
        }
    };
    
    this.showTabs = function() {
        var self = this;
        $(this.configurator_tabs_id+' '+this.configurator_tab_page_class).bind('click', function (event){
            var $currentTarget = $(event.currentTarget);

            if ($currentTarget.attr('disabled')) {
                return;
            }

            var block = $currentTarget.attr('data-block');

            $currentTarget.closest(self.configurator_tabs_id).find(self.configurator_tab_page_class).attr('data-selected', 'false');
            $currentTarget.attr('data-selected', 'true');

            $(self.step_list_class).find(self.step_group_class).hide();
            $(self.step_list_class).find(self.step_group_class+'.'+block).each(function (i, element){
                if($(element).attr('data-display') === 'true'){
                    $(element).show();
                }
            });
            self.displayActionTab();
            self.goToTopTab();
        });
    };
    
    this.hideTabs = function() {
        $(this.configurator_tabs_id+' '+this.configurator_tab_page_class).unbind('click');
    };
    
    this.nextTab = function() {
        var self = this;
        $(self.configurator_tabs_actions_class+' '+self.tab_action_next_id).bind('click', function (event){
            var selected_tab = $(self.configurator_tabs_id).find(self.configurator_tab_page_class+"[data-selected=true]");
            var next_tab = selected_tab.nextAll(self.getDisplaySelector());
            console.log(next_tab);
            if(next_tab.length > 0) {
                next_tab.first().trigger('click');
            }
        });
        $(self.configurator_block).on('click', self.tab_action_next_preview, function (event){
            $(self.configurator_tabs_actions_class+' '+self.tab_action_next_id).trigger('click');
        });
    };
    
    this.previousTab = function() {
        var self = this;
        $(self.configurator_tabs_actions_class+' '+self.tab_action_previous_id).bind('click', function (event){
            var selected_tab = $(self.configurator_tabs_id).find(self.configurator_tab_page_class+"[data-selected=true]");
            var previous_tab = selected_tab.prevAll(self.getDisplaySelector());
            console.log(previous_tab);
            if(previous_tab.length > 0) {
                previous_tab.first().trigger('click');
            }
        });
    };
    
    this.addToCartTab = function() {
        var self = this;
        $(self.configurator_tabs_actions_class+' '+self.tab_action_add_cart_id).bind('click', function (event){
            $(self.add_configurator_to_cart_id).trigger("click");
        });
        $(self.configurator_accordions_actions_class+' '+self.accordion_action_add_to_cart_class).bind('click', function (event){
            $(self.add_configurator_to_cart_id).trigger("click");
        });
    };
    
    this.displayActionTab = function() {
        var self = this;
        var selected_tab = $(self.configurator_tabs_id).find(self.configurator_tab_page_class+"[data-selected=true]");
        var next_tab = selected_tab.nextAll(self.getDisplaySelector());
        var previous_tab = selected_tab.prevAll(self.getDisplaySelector());
        
        if(selected_tab.length > 0 && (previous_tab.length > 0 || next_tab.length > 0)) {
            $(self.configurator_tabs_actions_class+' '+self.tab_action_previous_id).show();
            $(self.configurator_tabs_actions_class+' '+self.tab_action_next_id).show();
            $(self.configurator_tabs_actions_class+' '+self.tab_action_add_cart_id).hide();
            $(self.add_configurator_to_cart_id).hide();
            $(self.tab_action_next_preview).show();

            if ($(selected_tab).attr('data-valid') === 'false') {
                $(self.configurator_tabs_actions_class+' '+self.tab_action_next_id).addClass('disabled');
                $(self.configurator_tabs_actions_class+' '+self.tab_action_add_cart_id).addClass('disabled');
                $(self.add_configurator_to_cart_id).addClass('disabled');
                $(self.tab_action_next_preview).addClass('disabled');
            } else {
                $(self.configurator_tabs_actions_class+' '+self.tab_action_next_id).removeClass('disabled');
                $(self.configurator_tabs_actions_class+' '+self.tab_action_add_cart_id).removeClass('disabled');
                $(self.add_configurator_to_cart_id).removeClass('disabled');
                $(self.tab_action_next_preview).removeClass('disabled');
            }

            if(previous_tab.length <= 0) {
                self.displayActionOnFirstTab();
            } else if(next_tab.length <= 0) {
                self.displayActionOnLastTab();
            }
        }
    };
    
    this.displayActionOnFirstTab = function() {
        $(this.configurator_tabs_actions_class+' '+this.tab_action_previous_id).hide();
    };
    
    this.displayActionOnLastTab = function() {
        $(this.configurator_tabs_actions_class+' '+this.tab_action_next_id).hide();
        $(this.configurator_tabs_actions_class+' '+this.tab_action_add_cart_id).show();
        $(this.add_configurator_to_cart_id).show();
        $(this.tab_action_next_preview).hide();
    };
    
    this.goToTopTab = function() {
        var tabs = $(this.configurator_tabs_id);
        $('html, body').stop().animate({
	        'scrollTop': tabs.offset().top
	    }, 900);
    };

    this.changeQuantity = function() {
        var self = this;
        $(self.configurator_block).on('change', self.configurator_quantity, function (event) {
            Front.notify();
        });
    };

    this.changeSharedStep = function() {
        var self = this;
        $(self.configurator_block).on('click', self.configurator_change_shared_step, function (event) {
            Front.changeSharedStep();
        });
    };

    this.refreshCartPreviewButtons = function() {
        var self = this;
        var selected_tab = $(self.configurator_tabs_id).find(self.configurator_tab_page_class + "[data-selected=true]");
        if (selected_tab.length > 0 && selected_tab.next().length > 0) {
            $(self.add_configurator_to_cart_id).hide();
            $(self.tab_action_next_preview).show();
        }
    };

    this.refreshTabsStatus = function(tabs_status) {
        var self = this;
        if (typeof tabs_status !== 'undefined') {
            var allTabs = $(self.configurator_tabs_id).find(self.configurator_tab_page_class);
            var valid = true;
            for (const tab of allTabs) {
                var tabId = parseInt($(tab).attr('data-block').replace('configurator-tab-',''));
                $(tab).attr('disabled', !valid);
                if (typeof tabs_status[tabId] !== 'undefined') {
                    valid = (valid && tabs_status[tabId]['valid']);
                }
                $(tab).attr('data-valid', valid);

                if (self.getDisplaySelector().length) {
                    var tabSteps = $('.step_group.configurator-tab-' + tabId + '[data-display=true]');
                    if (tabSteps.length) {
                        $(tab).attr('data-display', true);
                    } else {
                        $(tab).attr('data-display', false);
                    }
                }
            }

            var allHideTabs = $(self.configurator_tabs_id).find(self.configurator_tab_page_class + '[data-display=false]');
            allHideTabs.hide();

            var allShowTabs = $(self.configurator_tabs_id).find(self.configurator_tab_page_class + '[data-display=true]');
            allShowTabs.css('width', (95 / allShowTabs.length) + '%');
            allShowTabs.show();

            self.displayActionTab();
        }
    };

    this.getDisplaySelector = function() {
        if (typeof configurator_hide_empty_tabs != 'undefined' && configurator_hide_empty_tabs) {
            return '[data-display=true]';
        }

        return '';
    }
};