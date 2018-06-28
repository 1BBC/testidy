<section class="content-header">
	<h1>
	  %HEADER%
	  <small>%HEADER_SMALL%</small>
	</h1>
</section>

%MESSAGE%
<section class="content">
	<form name='report_panel' class='form form-inline form-main text-center' >
	<div class="well well-sm">
		<div class="pull-center">
			<div class='form-group'>
			  <label>_{SEARCH_BY}_:</label>
			      <select class="form-control" name='select'>
			            <option value="1">_{TESTS_SEARCH}_</option>
			            <option value="2" %SORT_SELECTED%>_{USERS_SEARCH}_</option>
			          </select>
			</div>
			<div class='form-group'>
			  <label>_{REQUEST}_:</label>
			    <input type="text" name="q" value="%SEARCH%" class="form-control">
			</div>
		<div class="form-group"><input type="submit" class="btn btn-primary" value="_{SEARCH}_"></div>			
		</div>

   </div>
   </form>
	<div class="box box-theme">
	            <div class="box-header">
	              <h3 class="box-title">_{RESULTS}_</h3>

	              <div class="box-tools">
	                <ul class="pagination pagination-sm no-margin pull-right">
	                  <li><a href="#">«</a></li>
	                  <li><a href="#">1</a></li>
	                  <li><a href="#">»</a></li>
	                </ul>
	              </div>
	            </div>
	            <!-- /.box-header -->
	            <div class="box-body no-padding">
					<div class="row flex_box">
					  %TEST_BOX%

					</div>
	            </div>
	            <!-- /.box-body -->
	          </div>
</section>

<style type="text/css">
  .flex_box, .flex_item {
      display: -webkit-box;
      display: -moz-box;
      display: -ms-flexbox;
      display: -webkit-flex;
      display: flex;
      -ms-flex-wrap: wrap;
      -webkit-flex-wrap: wrap;
      flex-wrap: wrap;
      -ms-flex-align: flex-start;
      -webkit-align-items: flex-start;
      -webkit-box-align: flex-start;
      align-items: flex-start;
      float: none;
  }
</style>