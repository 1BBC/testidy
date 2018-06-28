        <div class="modal fade" id="modal%ID%" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">_{CHG_RESULT}_ №%COUNT%</h4>
              </div>
              <div class="modal-body">
                <form>
                  <input name="create_result" type="hidden" value="%TEST_ID%">
                  <input name="chg" type="hidden" value="yes">
                  <input name="id"  type="hidden" value="%ID%">
                   <div class="form-group">
                     <label for="recipient-name" class="control-label">_{NAME}_:</label>
                     <input type="text" class="form-control" value="%NAME%" name="name" placeholder="_{RESULT_NAME}_">
                   </div>
                   <div class="form-group">
                     <label for="recipient-name" class="control-label">URL:</label>
                     <input type="text" class="form-control" value="%URL%" name="url" placeholder="_{IMG}_">
                   </div>
                   <div class="form-group">
                     <label for="message-text" class="control-label">_{DESCRIPTION}_:</label>
                     <textarea class="form-control" rows="7" name="description" placeholder="_{RESULT_DESCRIPTION}_">%DESCRIPTION%</textarea>
                   </div>    
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">_{CLOSE}_</button>
                <button type="submit" class="btn btn-success">_{CHG}_</button>
                </form>
              </div>
            </div>
          </div>
        </div>

        <div class="modal modal-danger fade" id="modal-danger%ID%">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">_{DEL_RESULT}_ №%COUNT%</h4>
              </div>
              <div class="modal-body">
                <p>_{DEL_OK}_</p>

                <div class="form-group">
                  <label for="recipient-name" class="control-label">_{NAME}_:</label>
                  <input type="text" class="form-control" value="%NAME%" name="name" disabled>
                </div>
                <div class="form-group">
                  <label for="recipient-name" class="control-label">URL:</label>
                  <input type="text" class="form-control" value="%URL%" name="url" disabled>
                </div>
                <div class="text-center">
                  <img src="%URL%" class="img-responsive" alt="%URL%">
                </div>
                <div class="form-group">
                  <label for="message-text" class="control-label">_{DESCRIPTION}_:</label>
                  <textarea class="form-control" rows="7" name="description" disabled>%DESCRIPTION%</textarea>
                </div>    
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">_{CLOSE}_</button>
                <form>
                  <input name="del"  type="hidden" value="%ID%">
                  <input name="create_result" type="hidden" value="%TEST_ID%">
                  <button type="submit" class="btn btn-outline">_{DEL}_</button>
                </form>
              </div>
            </div>
            <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog -->
        </div>