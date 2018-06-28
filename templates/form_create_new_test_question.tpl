<section class="content-header">
    <h1>
      _{CONSTRUCT_TEST}_
      <small>_{QUESTION_SETTINGS}_</small>
    </h1>
</section>

<section class="content">
	<form>
	<input name="create_new_question" type="hidden" value="yes">
	<input name="create_new_test" type="hidden" value="yes">
	<input name="test_id" type="hidden" value="%TEST_ID%">

	<div class="box box-theme">
	        <div class="box-header with-border">
	          <h3 class="box-title">_{QUESTION}_</h3>

	          <div class="box-tools pull-right">
	            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
	          </div>
	        </div>

	        <div class="box-body">
	          <div class="row">
	            <div class="col-md-6">
	              <div class="form-group">
	                <label for="recipient-name" class="control-label required">_{NAME}_:</label>
	                <input type="text" class="form-control" value="%NAME%" name="name" placeholder="_{QUESTION_NAME}_" required>
	              </div>

	              <div class="form-group">
	                <label for="recipient-name" class="control-label">URL:</label>
	                <input type="text" class="form-control" value="%URL%" name="url" placeholder="_{IMG}_">
	              </div>
	          </div>

	            <div class="col-md-6">
					 <div class="form-group">
					    <label for="message-text" class="control-label">_{DESCRIPTION}_:</label>
					    <textarea class="form-control" rows="5" name="description" placeholder="_{QUESTION_DESCRIPTION}_">%DESCRIPTION%</textarea>
					 </div>
				</div>

	        </div>
			</div>

			<div class="box-header bg-info">
			  <h3 class="box-title">_{OPTION_ANSWER}_</h3>
				
			  <div class="box-tools pull-right">
			  </div>
			</div>

			        <div class="box-body bg-info">
			        <div class="row center" id="formet">
						<div id="clonedInput1" class="clonedInput col-md-4">
						  <div class="box">

						    <div class="box-body">

						      <div class="form-group">
						        <input type="text" class="form-control my-colorpicker1 colorpicker-element" name="answers" value="%ANSWERS_NAME%" placeholder="_{ANSWER}_" required>
						      </div>
						      
						      %ANSWERS_ROW%

						    </div>
						                      <!-- /.box-body -->
						  </div>

						  <div class="actions btn-group" role="group">
						    <a class="btn btn-xs btn-success clone"><span class="glyphicon glyphicon-plus"></span> </a>
						    <a class="btn btn-xs btn-danger remove"><span class="glyphicon glyphicon-minus"></span> </a>
						  </div>
						  <br>
						  <br>
						</div>

			        </div>
					</div>
	        <div class="box-footer">
	        	<div class="pull-right btn-group" role="group">
	        		<button type="submit" class="btn btn-warning" name="create_mod_of" value="1">_{END_CREATE_TEST}_</button>
	          		<button type="submit" class="btn btn-success">_{ADD_QUESTION}_</button>
	          </div>
	        </div>
	      </div>
	</form>
</section>

<script type="text/javascript">
  var regex = /^(.+?)(\d+)/i;
  var cloneIndex = jQuery(".clonedInput").length;

  function clone(){
      jQuery(this).parents(".clonedInput").clone()
          .appendTo("#formet")
          .attr("id", "clonedInput" +  cloneIndex)
          .find("*")
          .each(function() {
              var id = this.id || "";
              var match = id.match(regex) || [];
              if (match.length == 3) {
                  this.id = match[1] + (cloneIndex);
              }
          })
          .on('click', 'a.clone', clone)
          .on('click', 'a.remove', remove);
      cloneIndex++;
  }
  function remove(){
      jQuery(this).parents(".clonedInput").remove();
  }
  jQuery("a.clone").on("click", clone);

  jQuery("a.remove").on("click", remove);
</script>

<style type="text/css">
  
  .range {
      display: table;
      position: relative;
      height: 25px;
      margin-top: 20px;
      background-color: rgb(245, 245, 245);
      border-radius: 4px;
      -webkit-box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1);
      box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1);
      cursor: pointer;
  }

  .range input[type="range"] {
      -webkit-appearance: none !important;
      -moz-appearance: none !important;
      -ms-appearance: none !important;
      -o-appearance: none !important;
      appearance: none !important;

      display: table-cell;
      width: 100%;
      background-color: transparent;
      height: 25px;
      cursor: pointer;
  }
  .range input[type="range"]::-webkit-slider-thumb {
      -webkit-appearance: none !important;
      -moz-appearance: none !important;
      -ms-appearance: none !important;
      -o-appearance: none !important;
      appearance: none !important;

      width: 11px;
      height: 25px;
      color: rgb(255, 255, 255);
      text-align: center;
      white-space: nowrap;
      vertical-align: baseline;
      border-radius: 0px;
      background-color: rgb(153, 153, 153);
  }

  .range input[type="range"]::-moz-slider-thumb {
      -webkit-appearance: none !important;
      -moz-appearance: none !important;
      -ms-appearance: none !important;
      -o-appearance: none !important;
      appearance: none !important;
      
      width: 11px;
      height: 25px;
      color: rgb(255, 255, 255);
      text-align: center;
      white-space: nowrap;
      vertical-align: baseline;
      border-radius: 0px;
      background-color: rgb(153, 153, 153);
  }

  .range output {
      display: table-cell;
      padding: 3px 5px 2px;
      min-width: 40px;
      color: rgb(255, 255, 255);
      background-color: rgb(153, 153, 153);
      text-align: center;
      text-decoration: none;
      border-radius: 4px;
      border-bottom-left-radius: 0;
      border-top-left-radius: 0;
      width: 1%;
      white-space: nowrap;
      vertical-align: middle;

      -webkit-transition: all 0.5s ease;
      -moz-transition: all 0.5s ease;
      -o-transition: all 0.5s ease;
      -ms-transition: all 0.5s ease;
      transition: all 0.5s ease;

      -webkit-user-select: none;
      -khtml-user-select: none;
      -moz-user-select: -moz-none;
      -o-user-select: none;
      user-select: none;
  }
  .range input[type="range"] {
      outline: none;
  }

  .range.range-primary input[type="range"]::-webkit-slider-thumb {
      background-color: rgb(66, 139, 202);
  }
  .range.range-primary input[type="range"]::-moz-slider-thumb {
      background-color: rgb(66, 139, 202);
  }
  .range.range-primary output {
      background-color: rgb(66, 139, 202);
  }
  .range.range-primary input[type="range"] {
      outline-color: rgb(66, 139, 202);
  }

  .range.range-success input[type="range"]::-webkit-slider-thumb {
      background-color: rgb(92, 184, 92);
  }
  .range.range-success input[type="range"]::-moz-slider-thumb {
      background-color: rgb(92, 184, 92);
  }
  .range.range-success output {
      background-color: rgb(92, 184, 92);
  }
  .range.range-success input[type="range"] {
      outline-color: rgb(92, 184, 92);
  }

  .range.range-info input[type="range"]::-webkit-slider-thumb {
      background-color: rgb(91, 192, 222);
  }
  .range.range-info input[type="range"]::-moz-slider-thumb {
      background-color: rgb(91, 192, 222);
  }
  .range.range-info output {
      background-color: rgb(91, 192, 222);
  }
  .range.range-info input[type="range"] {
      outline-color: rgb(91, 192, 222);
  }

  .range.range-warning input[type="range"]::-webkit-slider-thumb {
      background-color: rgb(240, 173, 78);
  }
  .range.range-warning input[type="range"]::-moz-slider-thumb {
      background-color: rgb(240, 173, 78);
  }
  .range.range-warning output {
      background-color: rgb(240, 173, 78);
  }
  .range.range-warning input[type="range"] {
      outline-color: rgb(240, 173, 78);
  }

  .range.range-danger input[type="range"]::-webkit-slider-thumb {
      background-color: rgb(217, 83, 79);
  }
  .range.range-danger input[type="range"]::-moz-slider-thumb {
      background-color: rgb(217, 83, 79);
  }
  .range.range-danger output {
      background-color: rgb(217, 83, 79);
  }
  .range.range-danger input[type="range"] {
      outline-color: rgb(217, 83, 79);
  }
	
</style>