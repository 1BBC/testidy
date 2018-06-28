<section class="content-header">
    <h1>
      _{CONSTRUCT_TEST}_
      <small>_{YOU_END_TEST}_</small>
    </h1>
</section>

<section class="content">
	<div class="alert alert-success alert-dismissible">
	                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
	                <h4><i class="icon fa fa-check"></i> _{CONGRULATION}_</h4>
	                _{GOOD_END_TEST}_
	              </div>
	<section class="content">
		<form>
		<input name="create_new_question" type="hidden" value="yes">
		<input name="create_new_test" type="hidden" value="yes">
		<input name="test_id" type="hidden" value="%TEST_ID%">

		<div class="box box-theme">
				<div class="box-header with-border">
				  <h3 class="box-title">_{FRIEND_SHARE}_</h3>

				  <div class="box-tools pull-right">
				    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
				  </div>
				</div>
		        <div class="box-body">
		        	<blockquote class="pull-right">
		        			        	                <p>_{FRANSUA_TEXT}_</p>
		        			        	                <small>_{FRANSUA}_</small>
		        			        	              </blockquote>
		        	<div class="text-center">
		        		<img src="https://mir-s3-cdn-cf.behance.net/project_modules/disp/2ad22110835825.560ebf9825bf6.gif" class="rounded">
		        	</div>
					


					<div class="nav-tabs-custom">
					            <ul class="nav nav-tabs">
					              <li class="active"><a href="#tab_1" data-toggle="tab">_{HREF}_</a></li>
					              <li><a href="#tab_2" data-toggle="tab">QR _{SMALL_IMG}_</a></li>
					              <li class="pull-right"><a href="#" class="text-muted"><i class="fa fa-link"></i></a></li>
					            </ul>
					            <div class="tab-content">
					              <div class="tab-pane active" id="tab_1">
					                <b>_{COPY_BUF}_:</b>

					                <div class="input-group input-group-lg">
					                    <input type="text" class="form-control" id='copyInput' value="%DOMEN_NAME%/?test=%TEST_ID%">
					                    <span class="input-group-btn">
					                      <button type="button" class="btn btn-success btn-flat" onclick="copyFunction()"><i class="glyphicon glyphicon-pencil"></i></button>
					                    </span>
					                </div>
					              </div>
					              <!-- /.tab-pane -->
					              <div class="tab-pane" id="tab_2">
					           		<b>QR _{CODE}_:</b>
					                <div class="text-center">
					                  <img src="https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=%DOMEN_NAME%/?test=%TEST_ID%" class="rounded" alt="%DOMEN_NAME%/?test=%TEST_ID%">
					                </div>
					              </div>
					              <!-- /.tab-pane -->
					            </div>
					            <!-- /.tab-content -->
					          </div>		
				</div>

		        <div class="box-footer">
		        	<div class="pull-right btn-group" role="group">
		        		<a href="/?create_test=yes" class="btn btn-primary">_{MY_TESTS_LIST}_</a>
		          		<a href="/?test=%TEST_ID%" class="btn btn-success">_{TO_TEST}_</a>
		          </div>
		        </div>
		      </div>
		</form>
	</section>
</section>

<script type="text/javascript">
  function copyFunction() {
    /* Get the text field */
    var copyText = document.getElementById("copyInput");

    /* Select the text field */
    copyText.select();

    /* Copy the text inside the text field */
    document.execCommand("copy");

    /* Alert the copied text */
    alert("Скопированый текст: " + copyText.value);
  }
</script>
