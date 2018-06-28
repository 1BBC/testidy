<section class="content-header">
    <h1>
      _{CONSTRUCT_TEST}_
      <small>_{SET_CONT_TEST}_</small>
    </h1>
</section>

<section class="content">
	<form>
	<input name="create_new_test" type="hidden" value="yes">
	<input name="create_new_results" type="hidden" value="yes">
	<div class="box box-theme">
	        <div class="box-header with-border">
	          <h3 class="box-title">_{TEST_INFO}_</h3>

	          <div class="box-tools pull-right">
	            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
	          </div>
	        </div>

	        <div class="box-body">
	          <div class="row">
	            <div class="col-md-6">
	              <div class="form-group">
	                <label for="recipient-name" class="control-label required">_{NAME}_:</label>
	                <input type="text" class="form-control" value="%NAME%" name="name" placeholder="_{TEST_NAME}_" required>
	              </div>

	              <div class="form-group">
	                <label for="recipient-name" class="control-label">URL:</label>
	                <input type="text" class="form-control" value="%URL%" name="url" placeholder="_{IMG}_">
	              </div>

	              <div class="form-group">
	                <label for="message-text" class="control-label">_{DESCRIPTION}_:</label>
	                <textarea class="form-control" rows="5" name="description" placeholder="_{TEST_DESCRIPTION}_">%DESCRIPTION%</textarea>
	              </div>
	            </div>


	            <div class="col-md-6">
					<div class="form-group">
						<label for="message-text" class="control-label">_{TAGS}_:</label>
						<div class="form-group form-group-options">
							<div class="input-group input-group-option col-md-12">
								<input type="text" name="tags" pattern='^[a-zа-я0-9]+%DOLLAR%' autocomplete="off" class="form-control" placeholder="_{TAG}_">
								<span class="input-group-addon input-group-addon-remove">
									<span class="glyphicon glyphicon-remove"></span>
								</span>
							</div>
						</div>
					</div>
	            </div>

	          </div>

			  
	        </div>

	        <div class="box-footer ">
	          <button type="submit" class="btn btn-success">_{NEXT}_</button>
	        </div>
	      </div>
	</form>



</section>

<script type="text/javascript">

jQuery(function(){
    
	jQuery(document).on('focus', 'div.form-group-options div.input-group-option:last-child input', function(){
        
		var sInputGroupHtml = jQuery(this).parent().html();
		var sInputGroupClasses = jQuery(this).parent().attr('class');
		jQuery(this).parent().parent().append('<div class="'+sInputGroupClasses+'">'+sInputGroupHtml+'</div>');
        
	});
	
	jQuery(document).on('click', 'div.form-group-options .input-group-addon-remove', function(){
        
		jQuery(this).parent().remove();
        
	});
    
});

</script>

<style type="text/css">
/* 
    Text fields 
*/
div.input-group-option:last-child span.input-group-addon-remove{
    display: none;
}

div.input-group-option:last-child input.form-control{
    border-bottom-right-radius: 3px;
	border-top-right-radius: 3px;
}

div.input-group-option span.input-group-addon-remove{
	cursor: pointer;
}

div.input-group-option{
    margin-bottom: 3px;
}

</style>
