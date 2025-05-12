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

/* UPLOAD */
var CONFIGURATOR_PRODUCT_UPLOAD_MANAGER = {
    
    id_file: '#cover',
    id_btn_add_file: '#btn_add_file',
    id_div_preview_cover: '#configurator-preview-cover',
    id_img_preview_cover: '#configurator-preview-cover-img',
    
    init: function () {
        var self = this;
        $('body').find(self.id_btn_add_file).click(function() {
            var url = $('body').find(self.id_btn_add_file).data('target-url');
            var data = new FormData();
            if ($('body').find(self.id_file)[0].files[0]) {
                data.append('cover', $('body').find(self.id_file)[0].files[0]);
                $.ajax({
                    type: 'POST',
                    url: url,
                    data: data,
                    contentType: false,
                    processData: false,
                    success: function(response) {
                        response = JSON.parse(response);
                        if(response.success === 1) {
                            showSuccessMessage(response.message);
                            $("body").find(self.id_file).val("");
                            $('body').find(self.id_img_preview_cover).attr('src',response.cover_url);
                            $('body').find(self.id_div_preview_cover).show('slow');
                        } else {
                            showErrorMessage(response.errors);
                        }
                    },
                    error: function(response) {
                        console.log('upload error');
                        console.log(response);
                    }
                });
            }
        });
    },
    
};


/* DUPLICATE */

var CONFIGURATOR_PRODUCT_DUPLICATE_MANAGER = {
    
    id_btn_duplicate: '#configurator_btn_duplicate',
    
    init: function () {
		$(this.id_btn_duplicate).click(function() {
			var value = $('select[name="duplicate_configurator"]').val();
			window.location.href = $(this).data('href')+value;
		});
    },
    
};