<!-- ADD THE CLASS layout-top-nav TO REMOVE THE SIDEBAR. -->
<body class="layout-top-nav skin-green" style="height: auto; min-height: 100%;">
  <script type="text/javascript" src="https://vk.com/js/api/openapi.js?154"></script>

  <!-- VK Widget -->
  <div id="vk_community_messages"></div>
  <script type="text/javascript">
  VK.Widgets.CommunityMessages("vk_community_messages", 167808202, {expandTimeout: "120000",widgetPosition: "left",disableExpandChatSound: "1",tooltipButtonText: "Потрібна відповідь?"});
  </script>
<div class="wrapper" style="height: auto; min-height: 100%;">

  <header class="main-header">
    <nav class="navbar navbar-static-top">
      <div class="container">
        <div class="navbar-header">
          <a href="/" class="navbar-brand"><b>Tes</b>TIDY</a>
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse">
            <i class="fa fa-bars"></i>
          </button>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse pull-left" id="navbar-collapse">
          <ul class="nav navbar-nav">
             <li class="%ACTIVE_TESTS%"><a href="/?tests=yes"><i class="fa fa-file"></i> _{TESTS}_</a></li>
             <li class="%ACTIVE_TAGS%"><a href="/?tags=yes"><i class="fa fa-tags"></i> _{TAGS}_</a></li>
             %CREATE_TOOLS%
             <li class="%ACTIVE_FAQ%"><a href="/?FAQ=yes"><i class="fa fa-question-circle"></i> FAQ</a></li>
          </ul>
          <form class="navbar-form navbar-left" role="search">
            <div class="form-group">
              <input type="text" name="q" class="form-control" id="navbar-search-input" placeholder="_{SEARCH}_">
            </div>
          </form>
        </div>
        <!-- /.navbar-collapse -->
        <!-- Navbar Right Menu -->
        <div class="navbar-custom-menu">
          <ul class="nav navbar-nav">
            <li class="dropdown">
                          <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-globe fa-lg"></i><span class="caret"></span></a>
                          <ul class="dropdown-menu" role="menu">
                            <li><a href="/?lng=ukrainian"><img src="https://image.flaticon.com/icons/svg/555/555614.svg" alt="альтернативный текст"/></a></li>
                            <li><a href="/?lng=english"><img src="https://image.flaticon.com/icons/svg/555/555417.svg" alt="альтернативный текст"/></a></li>
                            <li><a href="/?lng=russian"><img src="https://image.flaticon.com/icons/svg/555/555451.svg" alt="альтернативный текст"/></a></li>
                          </ul>
                        </li>
            <!-- User Account Menu -->
            %USER_HEADER_TPL%
          </ul>
        </div>
        <!-- /.navbar-custom-menu -->
      </div>
      <!-- /.container-fluid -->
    </nav>
  </header>
  <div class="content-wrapper">
    <div class="container">
      %REGISTRATION_ERR_MESSAGE%
      %BODY_TPL%


