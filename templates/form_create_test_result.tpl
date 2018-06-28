<section class="content-header">
      <h1>
        _{RESULTS}_
        <small><a href="/?create_test=yes">_{TO_TEST_HREF}_</a></small>
      </h1>
    </section>

    <section class="content">
          <div class="row">
            <div class="box box-theme">
      <div class="box-header">
        <h3 class="box-title">_{LIST_RESULTS}_</h3>
        <div class="box-tools">
          <a data-toggle="modal" data-target="#add_modal" class="btn btn-sm btn-success"><span class="glyphicon glyphicon-plus"></span> </a>
        </div>
      </div>
      <!-- /.box-header -->
      <div class="box-body no-padding">
        <table class="table table-condensed">
          <tbody><tr>
            <th style="width: 5px">#</th>
            <th style="width: 5px">_{METKA}_</th>
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
                <h4 class="modal-title" id="myModalLabel">_{ADD_RESULT}_</h4>
              </div>
              <div class="modal-body">
                <form>
                  <input name="create_result" type="hidden" value="%TEST_ID%">
                  <input name="add" type="hidden" value="yes">
                   <div class="form-group">
                     <label for="recipient-name" class="control-label">_{NAME}_:</label>
                     <input type="text" class="form-control" name="name">
                   </div>
                   <div class="form-group">
                     <label for="recipient-name" class="control-label">URL:</label>
                     <input type="text" class="form-control" name="url">
                   </div>
                   <div class="form-group">
                     <label for="message-text" class="control-label">_{DESCRIPTION}_:</label>
                     <textarea class="form-control" rows="7" name="description"></textarea>
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