<section class="content-header">
	<h1>
	  _{USER_ACC}_
	  <small>@%LOGIN%</small>
	</h1>
</section>

%MESSAGE%
<section class="content">

      <div class="row">
        <div class="col-md-3">

          <!-- Profile Image -->
          <div class="box box-primary">
            <div class="box-body box-profile">
              <img class="profile-user-img img-responsive" src="%USER_URL%" alt="User profile picture">

              <h3 class="profile-username text-center">%USERNAME%</h3>

              <p class="text-muted text-center">%USR_STATUS%</p>

              <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>_{TESTS}_</b> <p class="pull-right">%TEST_COUNT%</p>
                </li>
                <li class="list-group-item">
                  <b>_{COMMENTS}_</b> <p class="pull-right">%COMMENTS_COUNT%</p>
                </li>
              </ul>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->

          <!-- About Me Box -->
          <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">_{ABOUT_ME}_</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">

              <strong><i class="fa fa-map-marker margin-r-5"></i> _{PERSONAL_DATA}_</strong>

              <p class="text-muted">%LOCATION%</p>

              <hr>

              <strong><i class="fa fa-file-text-o margin-r-5"></i> _{NOTES}_</strong>

              <p>%NOTES%</p>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
        <div class="col-md-9">
          <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
              <li class="active"><a href="#activity" data-toggle="tab">_{TESTS}_</a></li>
              <li><a href="#timeline" data-toggle="tab">_{LIKED}_</a></li>
            </ul>
            <div class="tab-content">
              <div class="active tab-pane" id="activity">
                  <div class="row flex_box">
                    %TEST_BOX%

                  </div>
                

                
              </div>
              <!-- /.tab-pane -->
              <div class="tab-pane" id="timeline">
                  <div class="row flex_box">
                    %LIKE_TEST_BOX%

                  </div>
              </div>
              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div>
          <!-- /.nav-tabs-custom -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->

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