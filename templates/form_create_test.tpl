<section class="content-header">
      <h1>
        _{MY_TESTS}_
        <small>_{MY_TESTS_LIST}_</small>
      </h1>
    </section>

    <section class="content">
          <div class="row">
            <div class="box box-theme">
      <div class="box-header">
        <h3 class="box-title">_{TESTS}_</h3>
        <div class="box-tools">
          <a href="?create_new_test=yes" class="btn btn-sm btn-success">_{ADD_TEST}_ &nbsp<span class="glyphicon glyphicon-plus"></span> </a>
        </div>
      </div>
      <!-- /.box-header -->
      <div class="box-body no-padding">
        <table class="table table-condensed">
          <tbody><tr>
            <th style="">#</th>
            <th style="">_{NAME}_</th>
            <th style="">_{RESULTS}_</th>
            <th style="">_{QUESTIONS}_</th>
            <th style="">_{TAGS}_</th>
<!--             <th style="">Рейтинг</th>
            <th style="">Создано</th> -->
            <th style=""></th>
          </tr>
        %ROWS%
        </tbody></table>
      </div>
      <!-- /.box-body -->
    </div>
          </div>
        </section>
        %MODALS%

        <script type="text/javascript">

        jQuery(function(){
            
          jQuery(document).on('focus', 'div.form-group-options div.input-group-option:last-child input', function(){
                
            var sInputGroupHtml = jQuery(this).parent().html();
            var sInputGroupClasses = jQuery(this).parent().attr('class');
            jQuery(this).parent().parent().append('<div class="'+sInputGroupClasses+'">'+sInputGroupHtml+'</div>');
                
          });
          
          jQuery(document).on('click', 'div.form-group-options .input-group-addon-remove', function(){
                
            jQuery(this).parent().remove();
                
          });
            
        });

        </script>

        <style type="text/css">
        /* 
            Text fields 
        */
        div.input-group-option:last-child span.input-group-addon-remove{
            display: none;
        }

        div.input-group-option:last-child input.form-control{
            border-bottom-right-radius: 3px;
          border-top-right-radius: 3px;
        }

        div.input-group-option span.input-group-addon-remove{
          cursor: pointer;
        }

        div.input-group-option{
            margin-bottom: 3px;
        }

        </style>