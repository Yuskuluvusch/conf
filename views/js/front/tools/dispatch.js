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
CONFIGURATOR.TOOLS = CONFIGURATOR.TOOLS || {};

/**
 * Object that allows to registered 'on the fly' new elements
 * First step: Registering
 *  CONFIGURATOR.TOOLS.dispatch.registerObject('key_word_for_object', MyObjectFunction);
 * Second step: when getAssociatedObject is called with 'key_word_for_object' 
 *  initialise new MyObjectFunction
 *  @param {Array} objectsInit array of initial objects to be registered
 */
CONFIGURATOR.TOOLS.dispatch = function(objectsInit){
    //
    // Contains all objects that have been registered
    // 'key'    => Object's element_type
    // 'value'  => Object's constructor, must be a function and will be called 
    //              using the 'new' key word
    //
    var registeredObjects = objectsInit || [];
    
    return {
        /**
         * Registers the given 'object' with 'key'
         * @param {string} key  Object's element_type
         * @param {type} object Associated Object
         */
        registerObject: function(key, object) {
            if (key && typeof(key) === 'string' && object) {
                registeredObjects[key] = object;
            }
        },
        /**
         * 
         * @param {type} key
         * @returns {String|Object} "'Unknown key ' + key" if key has not been registered
         *                          The new object constructor otherwise
         */
        getAssociatedObject: function(key) {
            var obj = "Unknown key: " + key;

            if(registeredObjects[key]){
                obj = registeredObjects[key];
            }

            return obj;
        }
    };  
};