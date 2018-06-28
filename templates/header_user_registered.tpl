<li class="dropdown messages-menu">
  <!-- Menu toggle button -->
  <a href="#" class="dropdown-toggle" data-toggle="dropdown">
    <i class="fa fa-envelope-o"></i>
    <span class="label label-warning">%COUNT_MESSAGE%</span>
  </a>
  <ul class="dropdown-menu">
    <li class="header">%COUNT_MESSAGE_INFO%</li>
    <li>
      <!-- inner menu: contains the messages -->
      <ul class="menu">
        %USER_BLOCK%
      </ul>
      <!-- /.menu -->
    </li>
    <li class="footer"><a href="/?viewd_message=yes">_{VIEWING_ALL}_</a></li>
  </ul>
</li>



<li class="dropdown user user-menu">
  <!-- Menu Toggle Button -->
  <a href="#" class="dropdown-toggle" data-toggle="dropdown">
    <!-- The user image in the navbar-->
    <img src="%URL%" class="user-image" alt="User Image">
    <!-- hidden-xs hides the username on small devices so only the image appears. -->
    <span class="hidden-xs">%USERNAME%</span>
  </a>
  <ul class="dropdown-menu bg-yellow">
    <!-- The user image in the menu -->
    <li class="user-header bg-yellow">
      <img src="%URL%" class="img-circle" alt="User Image">

      <p>
        @%LOGIN%
        <small>%DATE_REG%</small>
      </p>
    </li>
    <!-- Menu Body -->
<!--     <li class="user-body">
      <div class="row">
        <div class="col-xs-4 text-center">
          <a href="#">Followers</a>
        </div>
        <div class="col-xs-4 text-center">
          <a href="#">Sales</a>
        </div>
        <div class="col-xs-4 text-center">
          <a href="#">Friends</a>
        </div>
      </div>
    </li> -->
    <!-- Menu Footer-->
    <li class="user-footer">
      <div class="pull-left">
        <a href="/?my_profile=yes" class="btn btn-default btn-flat">_{PROFILE}_</a>
      </div>
      <div class="pull-right">
        <a href="/?signout=yes" class="btn btn-default btn-flat">_{SIGN_OUT}_</a>
      </div>
    </li>
  </ul>
</li>