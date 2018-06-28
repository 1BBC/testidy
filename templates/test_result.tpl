<section class="content-header">
    <h1>
      _{END_TEST}_
      <small><a href="%DOMEN_NAME%/?test=%TEST_ID%">%NAME%</a></small>
    </h1>
</section>

<section class="content">
	<div class="alert alert-success alert-dismissible">
	                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
	                <h4><img src="https://i.pinimg.com/originals/81/21/68/81216899eb20c22d508f96beb1698ae5.gif" width="40" class="rounded"> _{CONGRULATION}_</h4>
	                _{YOU_END_THIS_TEST}_ 
	</div>

	%MESSAGE%
	%REPORT_MESSAGE%
	%LIKE_MESSAGE%
	%COMMENT_MESSAGE%
	
		<div class="col-md-7">
			<div class="box box-solid">
			            <div class="box-header with-border" style="background-image: url(http://www.astro.gsu.edu/~riedel/images/25pc2006.gif);">

			              <h3 class="box-title">_{RESULTS}_</h3>
			            </div>
			            <!-- /.box-header -->
			            <div class="box-body">
			              <p class="lead text-center"><b>%NAME%</b></p>
						  %URL%
						  
						  <blockquote>
	 		                <p>%DESCR%</p>
						  </blockquote>
			            </div>
			            <!-- /.box-body -->
			          </div>

			<div class="box box-solid">
			            <div class="box-header with-border">
			              <h3 class="box-title">_{BAL}_</h3>
			            </div>
			            <!-- /.box-header -->
			            <div class="box-body">
			              <p>_{MAYBE_LIKE}_:</p>
			              
			              	<form>
			              		<input name="result" type="hidden" value="%RESULT%">
			              		<input name="test" type="hidden" value="%TEST_ID%">
			              		<div class="btn-group" role="group" aria-label="Basic example">
			              			%LIKE_BTNS%
			              		</div>
			              	</form>
			              
			          </br>
			          </br>

			              <p>_{REPORT_THIS_MES}_</p>
			              <a data-toggle="modal" data-target="#modal_report" class="btn btn-danger btn-sm">_{REPORT_TEST}_</a>
			            </div>

			            <!-- /.box-body -->
			          </div>

			<div class="nav-tabs-custom">
			            <ul class="nav nav-tabs">
			              <li class="active"><a href="#tab_1" data-toggle="tab">_{HREF}_</a></li>
			              <li><a href="#tab_2" data-toggle="tab">QR</a></li>
			              <li><a href="#tab_3" data-toggle="tab">HTML _{CODE}_ </a></li>
			              <li><a href="#tab_4" data-toggle="tab">FORUM _{CODE}_ </a></li>
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
			                <div class="text-center">
			                  <img src="https://api.qrserver.com/v1/create-qr-code/?size=100x100&data=%DOMEN_NAME%/?test=%TEST_ID%" class="rounded" alt="%DOMEN_NAME%/?test=%TEST_ID%">
			                </div>
			              </div>

			              <div class="tab-pane" id="tab_3">
			              	<div class="form-group text-center">
			              		<textarea class="form-control" rows="4">&lta href="%DOMEN_NAME%/?test=%TEST_ID%"> %NAME% &lt/a>&ltp> %DESCRIPTION% &lt/p></textarea>
			              	</div>
			                
			              </div>

			              <div class="tab-pane" id="tab_4">
			              	<div class="form-group text-center">
			              		<textarea class="form-control" rows="4"> [b] %NAME% [/b] %DESCRIPTION% [a] %DOMEN_NAME%/?test=%TEST_ID% [/a]</textarea>
			              	</div>
			                
			              </div>
			              <!-- /.tab-pane -->
			            </div>
			            <!-- /.tab-content -->
			          </div>
		</div>

	<div class="col-md-5">
		<div class="box box-solid">
            <div class="box-header with-border">
              <h3 class="box-title">_{VERF}_</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
					%PROBABILITY%
            </div>
            <!-- /.box-body -->
          </div>

          	<div class="info-box">
          	            <span class="info-box-icon bg-yellow"><i class="ion ion-ios-people-outline"></i></span>

          	            <div class="info-box-content">
          	              <span class="info-box-text">_{VIEWS}_</span>
          	              <span class="info-box-number">%VIEWING%</span>
          	            </div>
          	            <!-- /.info-box-content -->
          	          </div>

          	<div class="info-box">
          	            <span class="info-box-icon bg-red"><i class="ion ion-ios-heart-outline"></i></span>

          	            <div class="info-box-content">
          	              <span class="info-box-text">_{RATING}_</span>
          	              <span class="info-box-number">%RATING%</span>
          	            </div>
          	            <!-- /.info-box-content -->
          	          </div>

          	<div class="info-box">
          	            <span class="info-box-icon bg-aqua"><i class="fa fa-files-o"></i></span>

          	            <div class="info-box-content">
          	              <span class="info-box-text">_{DESCRIPTION}_</span>
          	              <em>%DESCRIPTION%</em> 
          	            </div>
          	            <!-- /.info-box-content -->
          	          </div>

          	<div class="info-box">
          	            <span class="info-box-icon bg-green"><i class="fa fa-user"></i></span>

          	            <div class="info-box-content">
          	              <span class="info-box-text">_{AUTOR}_</span>
          	              %TEST_USERNAME%
          	              <a href="?/user=%TEST_USER_ID%">@%TEST_USER_LOGIN%</a>
          	              
          	            </div>
          	            <!-- /.info-box-content -->
          	          </div>


	</div>

	<div class="col-md-12">
			<div class="box box-theme">
		        <div class="box-header with-border">
		          <h3 class="box-title">_{COMMENTS}_</h3>

		          <div class="box-tools pull-right">
		            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
		          </div>
		        </div>

		        <div class="box-body">
		        <form>
		        	%COMMENTS_BLOCK%
		        	<input name="result" type="hidden" value="%RESULT%">
			        <input name="test" type="hidden" value="%TEST_ID%">
			        <div class="form-group">
			        	<input class="form-control" type="text" name="comment" placeholder="_{YOUR_COMM}_">
			        </div>
		        	
		        </form>		  
		        </div>

		        
		      </div>
	</div>


</section>

<div class="modal modal-danger fade" id="modal_report">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">_{CREATE_REPORT}_ %NAME%</h4>
      </div>
      <form>
      <div class="modal-body">
        <div class="form-group">
          <label for="message-text" class="control-label">_{WHY_REP}_:</label>
          <textarea class="form-control" rows="7" name="report_description"></textarea>
        </div>    
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">_{CLOSE}_</button>
          <input name="result" type="hidden" value="%RESULT%">
          <input name="test" type="hidden" value="%TEST_ID%">
          <button type="submit" class="btn btn-outline">_{SEND}_</button>       
      </div>
      </form>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>


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
