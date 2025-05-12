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
 * Class that handles a progress bar. 
 * @param {Object} params      Initialisation parameters
 *                      progress_query  Query to select the targeted progress bar
 *                      start_color     Color used around 0%
 *                      end_color       Color used around 100%
 *                      start           Start % for animating        
 *                      end             End % for animating
 *                      
 */
CONFIGURATOR.MODULES.ProgressBar= function(params) {

    this.params;

    var DEFAULT_START_COLOR = '#00b0ee';

    var DEFAULT_END_COLOR = '#026799';

    /**
     * Stores current end % in order to provided an animation from this end
     * until the new one for future call on 'launch'.
     * Example: if currentEnd equals 50 and the value provided is 80. The 
     * animation will be only from 50 to 80 instead of 0 to 80
     */
    this.currentEnd = 0;

    /**
     * Init progress bar.
     * If start_color and end_color are not provided, there will be
     * replace by default color. Call 'launch' in order to have the init 
     * animation
     * @param {Object} params       See global comment
     */
    this.init = function(params) {
        this.params = params;

        this.params.start_color = this.params.start_color || DEFAULT_START_COLOR;
        this.params.end_color = this.params.end_color || DEFAULT_END_COLOR;
        
        this.currentEnd = 0;
        
        this.launch(params.start, params.end);
    };

    /**
     * Animates the progress bar.
     * if 'end' is provided, animates from start to end
     * if not, animates from currentEnd to start
     * @param {number} start    start value for progress bar animation
     * @param {number} end      Optional, end value for progress bar animation
     * @returns {undefined}
     */
    this.launch = function(start, end) {

        var prog = $(this.params.progress_query);

        // if not found, means that progress is not enable
        if (prog.length > 0) {
            var begin = start || 0;
            if (!end) { 
                end = begin;
                begin = this.currentEnd;
            }
            
            this.currentEnd = end;

            var param = this.generateParam(prog, begin, end);
            
            prog.circleProgress(param).on('circle-animation-progress', 
                                            this.onCircleAnimationProgress);
        }
    };

    /**
     * Generates parameters for circleProgress animation
     * @param {type} progressElement    targeted circle progress
     * @param {type} start              start value
     * @param {type} end                end value
     * @returns {Object} parameters for 'circleProgress'
     */
    this.generateParam = function(progressElement, start, end) {
        return {
            startAngle: -Math.PI / 2,
            animationStartValue: parseInt(start) / 100,
            value: parseInt(end) / 100,
            size: progressElement.width(),
            lineCap: 'round',
            fill: { 
                gradient: [this.params.start_color, 
                            this.params.end_color], 
                gradientAngle: Math.PI 
                }
        }; 
    };

    /**
     * Callend when the progress bar is animated
     * See 'launch' for more details
     * @param {type} event
     * @param {type} progress
     * @param {type} stepValue
     */
    this.onCircleAnimationProgress = function(event, progress, stepValue) {
        $(this).find('strong').html(parseInt(100 * stepValue) + '%');
    };


    if (params) {
        this.init(params);
    } 
};