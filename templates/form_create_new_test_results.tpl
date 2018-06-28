<section class="content-header">
    <h1>
      _{CONSTRUCT_TEST}_
      <small>_{END_SETTINGS}_</small>
    </h1>
</section>

<section class="content">
	<form>
	<input name="create_new_test" type="hidden" value="yes">
	<input name="create_new_questions" type="hidden" value="yes">
	<input name="test_id" type="hidden" value="%TEST_ID%">
	<div class="box box-theme">
	        <div class="box-header with-border">
	          <h3 class="box-title">_{TEST_RESULT}_</h3>

	          <div class="box-tools pull-right">
	            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
	          </div>
	        </div>

	        <div class="box-body">
	        	<div id="box-a">
				<div class="box box-solid">
				    <div class="box-header with-border">
				      <h3 class="box-title label label-success">A - _{ODIN}_ _{OPTION_RESULT}_</h3>
				    </div>
				            <!-- /.box-header -->
				    <div class="box-body">
			          <div class="row">
			            <div class="col-md-6">
			              <div class="form-group">
			                <label for="recipient-name" class="control-label">_{NAME}_:</label>
			                <input type="text" class="form-control" value="%NAME%" name="name" placeholder="_{RESULT_NAME}_" required>
			              </div>

			              <div class="form-group">
			                <label for="recipient-name" class="control-label">URL:</label>
			                <input type="text" class="form-control" value="%URL%" name="url" placeholder="_{IMG}_">
			              </div>
			            </div>

			            <div class="col-md-6">
							<div class="form-group">
							  <label for="message-text" class="control-label">_{DESCRIPTION}_:</label>
							  <textarea class="form-control" rows="5" name="description" placeholder="_{RESULT_DESCRIPTION}_">%DESCRIPTION%</textarea>
							</div> 
			            </div>

			          </div>
				    </div>
				</div>
				<br>
				</div>
				<div id="box-b">
				<div class="box box-solid">
				    <div class="box-header with-border">
				      <h3 class="box-title label label-warning">B - _{DVA}_ _{OPTION_RESULT}_</h3>
				    </div>
				            <!-- /.box-header -->
				    <div class="box-body">
			          <div class="row">
			            <div class="col-md-6">
			              <div class="form-group">
			                <label for="recipient-name" class="control-label">_{NAME}_:</label>
			                <input type="text" class="form-control" value="%NAME%" name="name" placeholder="_{RESULT_NAME}_" required>
			              </div>

			              <div class="form-group">
			                <label for="recipient-name" class="control-label">URL:</label>
			                <input type="text" class="form-control" value="%URL%" name="url" placeholder="_{IMG}_">
			              </div>
			            </div>

			            <div class="col-md-6">
							<div class="form-group">
							  <label for="message-text" class="control-label">_{DESCRIPTION}_:</label>
							  <textarea class="form-control" rows="5" name="description" placeholder="_{RESULT_DESCRIPTION}_">%DESCRIPTION%</textarea>
							</div> 
			            </div>

			          </div>
				    </div>
				</div>
				<br>
				</div>
				
				<div id="btn-c" onclick="btn_box_c()">
					<br>
					<a type="button" class="btn btn-primary btn-block btn-sm"><i class="fa fa-plus"></i></a>
				</div>

				<div id="box-c" style="display: none;">
				<div class="box box-solid">
				    <div class="box-header with-border">
				      <h3 class="box-title label label-primary">C - _{TRI}_ _{OPTION_RESULT}_</h3>
				    </div>
				            <!-- /.box-header -->
				    <div class="box-body">
			          <div class="row">
			            <div class="col-md-6">
			              <div class="form-group">
			                <label for="recipient-name" class="control-label">_{NAME}_:</label>
			                <input type="text" class="form-control" value="%NAME%" name="name" placeholder="_{RESULT_NAME}_">
			              </div>

			              <div class="form-group">
			                <label for="recipient-name" class="control-label">URL:</label>
			                <input type="text" class="form-control" value="%URL%" name="url" placeholder="_{IMG}_">
			              </div>
			            </div>

			            <div class="col-md-6">
							<div class="form-group">
							  <label for="message-text" class="control-label">_{DESCRIPTION}_:</label>
							  <textarea class="form-control" rows="5" name="description" placeholder="_{RESULT_DESCRIPTION}_">%DESCRIPTION%</textarea>
							</div> 
			            </div>

			          </div>
				    </div>
				</div>
				<br>
				</div>
				
				<div id="btn-d" onclick="btn_box_d()" style="display: none">
					<br>
					<a type="button" class="btn btn-primary btn-block btn-sm"><i class="fa fa-plus"></i></a>
				</div>

				<div id="box-d" style="display: none;">
				<div class="box box-solid">
				    <div class="box-header with-border">
				      <h3 class="box-title label label-danger">D - _{CHETIRI}_ _{OPTION_RESULT}_</h3>
				    </div>
				            <!-- /.box-header -->
				    <div class="box-body">
			          <div class="row">
			            <div class="col-md-6">
			              <div class="form-group">
			                <label for="recipient-name" class="control-label">_{NAME}_:</label>
			                <input type="text" class="form-control" value="%NAME%" name="name" placeholder="_{RESULT_NAME}_">
			              </div>

			              <div class="form-group">
			                <label for="recipient-name" class="control-label">URL:</label>
			                <input type="text" class="form-control" value="%URL%" name="url" placeholder="_{IMG}_">
			              </div>
			            </div>

			            <div class="col-md-6">
							<div class="form-group">
							  <label for="message-text" class="control-label">_{DESCRIPTION}_:</label>
							  <textarea class="form-control" rows="5" name="description" placeholder="_{RESULT_DESCRIPTION}_">%DESCRIPTION%</textarea>
							</div> 
			            </div>

			          </div>
				    </div>
				</div>
				<br>
				</div>
				
				<div id="btn-e" onclick="btn_box_e()" style="display: none">
					<br>
					<a type="button" class="btn btn-primary btn-block btn-sm"><i class="fa fa-plus"></i></a>
				</div>

				<div id="box-e" style="display: none;">
				<div class="box box-solid">
				    <div class="box-header with-border">
				      <h3 class="box-title label label-info">E - _{PAT}_ _{OPTION_RESULT}_</h3>
				    </div>
				            <!-- /.box-header -->
				    <div class="box-body">
			          <div class="row">
			            <div class="col-md-6">
			              <div class="form-group">
			                <label for="recipient-name" class="control-label">_{NAME}_:</label>
			                <input type="text" class="form-control" value="%NAME%" name="name" placeholder="_{RESULT_NAME}_">
			              </div>

			              <div class="form-group">
			                <label for="recipient-name" class="control-label">URL:</label>
			                <input type="text" class="form-control" value="%URL%" name="url" placeholder="_{IMG}_">
			              </div>
			            </div>

			            <div class="col-md-6">
							<div class="form-group">
							  <label for="message-text" class="control-label">_{DESCRIPTION}_:</label>
							  <textarea class="form-control" rows="5" name="description" placeholder="_{RESULT_DESCRIPTION}_">%DESCRIPTION%</textarea>
							</div> 
			            </div>

			          </div>
				    </div>
				</div>
				<br>
				</div>
				
				<div id="btn-f" onclick="btn_box_f()" style="display: none">
					<br>
					<a type="button" class="btn btn-primary btn-block btn-sm"><i class="fa fa-plus"></i></a>
				</div>

				<div id="box-f" style="display: none;">
				<div class="box box-solid">
				    <div class="box-header with-border">
				      <h3 class="box-title label label-default">F - _{CHEST}_ _{OPTION_RESULT}_</h3>
				    </div>
				            <!-- /.box-header -->
				    <div class="box-body">
			          <div class="row">
			            <div class="col-md-6">
			              <div class="form-group">
			                <label for="recipient-name" class="control-label">_{NAME}_:</label>
			                <input type="text" class="form-control" value="%NAME%" name="name" placeholder="_{RESULT_NAME}_">
			              </div>

			              <div class="form-group">
			                <label for="recipient-name" class="control-label">URL:</label>
			                <input type="text" class="form-control" value="%URL%" name="url" placeholder="_{IMG}_">
			              </div>
			            </div>

			            <div class="col-md-6">
							<div class="form-group">
							  <label for="message-text" class="control-label">_{DESCRIPTION}_:</label>
							  <textarea class="form-control" rows="5" name="description" placeholder="_{RESULT_DESCRIPTION}_">%DESCRIPTION%</textarea>
							</div> 
			            </div>

			          </div>
				    </div>
				</div>
				<br>
				</div>
				
	        </div>
			
	        <div class="box-footer">
	          <button type="submit" class="pull-right btn btn-success">_{NEXT}_</button>
	        </div>
	      </div>
	</form>
</section>

<script type="text/javascript">
	function btn_box_c() {
		var block = document.getElementById("box-c");
		var btn = document.getElementById("btn-c");
		var new_btn = document.getElementById("btn-d");
		block.style.display = "block";
		btn.style.display = "none";
		new_btn.style.display = "block";
	}

	function btn_box_d() {
		var block = document.getElementById("box-d");
		var btn = document.getElementById("btn-d");
		var new_btn = document.getElementById("btn-e");
		block.style.display = "block";
		btn.style.display = "none";
		new_btn.style.display = "block";
	}

	function btn_box_e() {
		var block = document.getElementById("box-e");
		var btn = document.getElementById("btn-e");
		var new_btn = document.getElementById("btn-f");
		block.style.display = "block";
		btn.style.display = "none";
		new_btn.style.display = "block";
	}

	function btn_box_f() {
		var block = document.getElementById("box-f");
		var btn = document.getElementById("btn-f");
		block.style.display = "block";
		btn.style.display = "none";
	}

</script>

<!-- <script type="text/javascript">
	var btn = document.getElementById("btn-c");
	btn.style.display = "none";
</script> -->
