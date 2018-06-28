<style>
   body{
    background-image: url(https://d2d00szk9na1qq.cloudfront.net/Product/0253a8ef-822e-4033-b9fa-416eae53f379/Images/Large_UG-775.jpg);
    background-size: 5%;
   } 
</style>
<div class="register-box">
  <div class="register-logo">
    <a href="/" style="color: white"><b>Tes</b>TIDY</a>
  </div>

  <div class="register-box-body">
    %message%
    
    <form method="post">
      <input type='hidden' name='registration' value='1' />

      <div class='form-group'>
        <div class="input-group control-label">
        <span class="input-group-addon" style="font-weight: bold;">@</span>
         <input type='text' id='login' required name='login' value='%login%' class='form-control' pattern='^[a-z0-9_]{4,15}+%DOLLAR%' placeholder='_{LOGIN}_'>
        </div>
      </div>

      <div class='form-group'>
        <div class="input-group">
         <span class="input-group-addon glyphicon glyphicon-user"></span>
         <input type='text' id='username' required name='username' value='%username%' pattern="{4,30}" class='form-control' placeholder='_{USERNAME}_'>
        </div>
      </div>

      <div class='form-group'>
        <div class="input-group">
         <span class="input-group-addon glyphicon glyphicon-envelope"></span>
         <input type='email' id='email' required name='email' value='%email%' class='form-control' placeholder='_{EMAIL}_'>
        </div>
      </div>

      <div class='form-group'>
        <div class="input-group">
          <span class="input-group-addon glyphicon glyphicon-lock"></span>
        <input type='PASSWORD' id='password' required name='password' class='form-control' pattern="{4,30}" value="%password%" placeholder='_{PASSWORD}_'>
        </div>
      </div>

      <div class='form-group'>
        <div class="input-group">
          <span class="input-group-addon glyphicon glyphicon-repeat"></span>
        <input type='password' id='repeat_password' required name='repeat_password' pattern="{4,30}" class='form-control' placeholder='_{REPEAT_PASSWORD}_'>
        </div>
      </div>

      <div class="row">
        <div class="col-xs-8">
        </div>
        <!-- /.col -->
        <div class="col-xs-4">
          <button type="submit" class="btn btn-success btn-block btn-flat" name="end_registration" value="1">_{CREATE}_</button>
        </div>
        <!-- /.col -->
      </div>
    </form>

    <a href="/" class="text-center">_{I_HAVE_ACC}_</a>
  </div>
  <!-- /.form-box -->
</div>