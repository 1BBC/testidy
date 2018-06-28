<li class="dropdown user-menu"> 
  <a class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user-circle fa-lg"></i> _{LOG_IN}_</a>
  <ul class="dropdown-menu">
    <!-- The user image in the menu -->
    <li class="user-body">
      <form method="post">
        <div class='form-group'>
          <div class="input-group">
           <span class="input-group-addon glyphicon glyphicon-user"></span>
           <input type='text' id='user' name='login' value='%login%' class='form-control' placeholder='_{LOGIN}_'>
          </div>
        </div>

        <div class='form-group'>
          <div class="input-group">
            <span class="input-group-addon glyphicon glyphicon-lock"></span>
          <input type='password' id='password' name='password' class='form-control' value="%password%" 
                 placeholder='_{PASSWORD}_'>
          </div>
        </div>

        <div class="pull-left">
          <button type='submit' name='logined' class="btn btn-default btn-flat btn-success" value="yes" style="color: white;">_{LOG_IN}_</button>
        </div>
        <div class="pull-right">
          <button type='submit' name='registration' class="btn btn-default btn-flat" value="yes" style="color: green;">_{REGISTRATION}_</button>
        </div>
      </form>
    </li>
  </ul>
</li>