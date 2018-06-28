<section class="content-header">
      <h1>
        _{QUESTIONS}_
        <small><a href="/?create_test=yes">_{TO_TEST_HREF}_</a></small>
      </h1>
    </section>

    <section class="content">
          <div class="row">
            <div class="box box-theme">
      <div class="box-header">
        <h3 class="box-title">_{QUESTIONS_LIST}_</h3>
        <div class="box-tools">
          <a data-toggle="modal" data-target="#add_modal" class="btn btn-sm btn-success"><span class="glyphicon glyphicon-plus"></span> </a>
        </div>
      </div>
      <!-- /.box-header -->
      <div class="box-body no-padding">
        <table class="table table-condensed">
          <tbody><tr>
            <th style="width: 10px">#</th>
            <th style="width: 20px">_{ANSWERS}_</th>
            <th style="width: 150px">_{NAME}_</th>
            <th style="width: 50px"></th>
          </tr>
        %ROWS%
        </tbody></table>
      </div>
      <!-- /.box-body -->
    </div>
          </div>
        </section>
        %MODALS%  


        <div class="modal fade" id="add_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">_{ADD_QUESTION}_</h4>
              </div>
              <div class="modal-body">
                <form>
                  <input name="create_questions" type="hidden" value="%TEST_ID%">
                  <input name="add" type="hidden" value="yes">
                   <div class="form-group">
                     <label for="recipient-name" class="control-label">_{NAME}_:</label>
                     <input type="text" class="form-control" name="name" placeholder="_{QUESTION_NAME}_">
                   </div>
                   <div class="form-group">
                     <label for="recipient-name" class="control-label">URL:</label>
                     <input type="text" class="form-control" name="url" placeholder="_{IMG}_">
                   </div>
                   <div class="form-group">
                     <label for="message-text" class="control-label">_{DESCRIPTION}_:</label>
                     <textarea class="form-control" rows="7" name="description" placeholder="_{QUESTION_DESCRIPTION}_"></textarea>
                   </div>    
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">_{CLOSE}_</button>
                <button type="submit" class="btn btn-success">_{ADD}_</button>
                </form>
              </div>
            </div>
          </div>
        </div>


<style type="text/css">
  
  .range {
      display: table;
      position: relative;
      height: 25px;
      margin-top: 20px;
      background-color: rgb(245, 245, 245);
      border-radius: 4px;
      -webkit-box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1);
      box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1);
      cursor: pointer;
  }

  .range input[type="range"] {
      -webkit-appearance: none !important;
      -moz-appearance: none !important;
      -ms-appearance: none !important;
      -o-appearance: none !important;
      appearance: none !important;

      display: table-cell;
      width: 100%;
      background-color: transparent;
      height: 25px;
      cursor: pointer;
  }
  .range input[type="range"]::-webkit-slider-thumb {
      -webkit-appearance: none !important;
      -moz-appearance: none !important;
      -ms-appearance: none !important;
      -o-appearance: none !important;
      appearance: none !important;

      width: 11px;
      height: 25px;
      color: rgb(255, 255, 255);
      text-align: center;
      white-space: nowrap;
      vertical-align: baseline;
      border-radius: 0px;
      background-color: rgb(153, 153, 153);
  }

  .range input[type="range"]::-moz-slider-thumb {
      -webkit-appearance: none !important;
      -moz-appearance: none !important;
      -ms-appearance: none !important;
      -o-appearance: none !important;
      appearance: none !important;
      
      width: 11px;
      height: 25px;
      color: rgb(255, 255, 255);
      text-align: center;
      white-space: nowrap;
      vertical-align: baseline;
      border-radius: 0px;
      background-color: rgb(153, 153, 153);
  }

  .range output {
      display: table-cell;
      padding: 3px 5px 2px;
      min-width: 40px;
      color: rgb(255, 255, 255);
      background-color: rgb(153, 153, 153);
      text-align: center;
      text-decoration: none;
      border-radius: 4px;
      border-bottom-left-radius: 0;
      border-top-left-radius: 0;
      width: 1%;
      white-space: nowrap;
      vertical-align: middle;

      -webkit-transition: all 0.5s ease;
      -moz-transition: all 0.5s ease;
      -o-transition: all 0.5s ease;
      -ms-transition: all 0.5s ease;
      transition: all 0.5s ease;

      -webkit-user-select: none;
      -khtml-user-select: none;
      -moz-user-select: -moz-none;
      -o-user-select: none;
      user-select: none;
  }
  .range input[type="range"] {
      outline: none;
  }

  .range.range-primary input[type="range"]::-webkit-slider-thumb {
      background-color: rgb(66, 139, 202);
  }
  .range.range-primary input[type="range"]::-moz-slider-thumb {
      background-color: rgb(66, 139, 202);
  }
  .range.range-primary output {
      background-color: rgb(66, 139, 202);
  }
  .range.range-primary input[type="range"] {
      outline-color: rgb(66, 139, 202);
  }

  .range.range-success input[type="range"]::-webkit-slider-thumb {
      background-color: rgb(92, 184, 92);
  }
  .range.range-success input[type="range"]::-moz-slider-thumb {
      background-color: rgb(92, 184, 92);
  }
  .range.range-success output {
      background-color: rgb(92, 184, 92);
  }
  .range.range-success input[type="range"] {
      outline-color: rgb(92, 184, 92);
  }

  .range.range-info input[type="range"]::-webkit-slider-thumb {
      background-color: rgb(91, 192, 222);
  }
  .range.range-info input[type="range"]::-moz-slider-thumb {
      background-color: rgb(91, 192, 222);
  }
  .range.range-info output {
      background-color: rgb(91, 192, 222);
  }
  .range.range-info input[type="range"] {
      outline-color: rgb(91, 192, 222);
  }

  .range.range-warning input[type="range"]::-webkit-slider-thumb {
      background-color: rgb(240, 173, 78);
  }
  .range.range-warning input[type="range"]::-moz-slider-thumb {
      background-color: rgb(240, 173, 78);
  }
  .range.range-warning output {
      background-color: rgb(240, 173, 78);
  }
  .range.range-warning input[type="range"] {
      outline-color: rgb(240, 173, 78);
  }

  .range.range-danger input[type="range"]::-webkit-slider-thumb {
      background-color: rgb(217, 83, 79);
  }
  .range.range-danger input[type="range"]::-moz-slider-thumb {
      background-color: rgb(217, 83, 79);
  }
  .range.range-danger output {
      background-color: rgb(217, 83, 79);
  }
  .range.range-danger input[type="range"] {
      outline-color: rgb(217, 83, 79);
  }

</style>