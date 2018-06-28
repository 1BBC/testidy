        <div class="modal fade" id="modal%ID%" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">_{CHG_TEST}_ №%COUNT%</h4>
              </div>
              <div class="modal-body">
                <form>
                  <input name="create_test" type="hidden" value="yes">
                  <input name="chg" type="hidden" value="yes">
                  <input name="id"  type="hidden" value="%ID%">
                   <div class="form-group">
                     <label for="recipient-name" class="control-label">_{CHG_TEST}_:</label>
                     <input type="text" class="form-control" value="%NAME%" name="name" placeholder="_{TEST_NAME}_">
                   </div>
                   <div class="form-group">
                     <label for="recipient-name" class="control-label">URL:</label>
                     <input type="text" class="form-control" value="%URL%" name="url" placeholder="_{IMG}_">
                   </div>
                   <div class="form-group">
                     <label for="message-text" class="control-label">_{DESCRIPTION}_:</label>
                     <textarea class="form-control" rows="7" name="description" placeholder="_{TEST_DESCRIPTION}_">%DESCRIPTION%</textarea>
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

        <div class="modal fade" id="modal_tags%ID%" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">_{TAGS_FOR_TESTS}_ №%COUNT%</h4>
              </div>
              <div class="modal-body">
                <form>
                  <input name="create_test" type="hidden" value="yes">
                  <input name="chg_tags" type="hidden" value="%ID%">
                   <div class="form-group">
                    <div class="form-group form-group-options">
                      %TAGS_ROW%
                      <div class="input-group input-group-option col-md-12">
                        <input type="text" name="tags" pattern='^[a-zа-я0-9]+%DOLLAR%' autocomplete="off" class="form-control" placeholder="_{TAG}_">
                        <span class="input-group-addon input-group-addon-remove">
                          <span class="glyphicon glyphicon-remove"></span>
                        </span>
                      </div>
                    </div>
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
                  <input name="create_test" type="hidden" value="yes">
                  <button type="submit" class="btn btn-outline">_{DEL}_</button>
                </form>
              </div>
            </div>
            <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog -->
        </div>

        <div class="modal fade" id="modal-link%ID%" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">_{SHARE_TEST_HREF}_ №%COUNT%</h4>
              </div>
              <div class="modal-body">
                <form>
                  <input name="test" type="hidden" value="%ID%">
                  <div class="form-group">
                    <label for="recipient-name" class="control-label">_{COPY_BUF}_:</label>
                    <div class="input-group input-group-lg">
                        <input type="text" class="form-control" id='copyInput%ID%' value="%DOMEN_NAME%/?test=%ID%">
                        <span class="input-group-btn">
                          <button type="button" class="btn btn-success btn-flat" onclick="copyFunction%ID%()"><i class="glyphicon glyphicon-pencil"></i></button>
                        </span>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="recipient-name" class="control-label">QR _{CODE}_:</label>
                    <div class="text-center">
                      <img src="https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=%DOMEN_NAME%/?test=%ID%" class="rounded" alt="%DOMEN_NAME%/?test=%ID%">
                    </div>
                  </div>    
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">_{CLOSE}_</button>
                <button type="submit" class="btn btn-success">_{TO_TEST}_</button>
                </form>
              </div>
            </div>
          </div>
        </div>

        <script type="text/javascript">
          function copyFunction%ID%() {
            /* Get the text field */
            var copyText = document.getElementById("copyInput%ID%");

            /* Select the text field */
            copyText.select();

            /* Copy the text inside the text field */
            document.execCommand("copy");

            /* Alert the copied text */
            alert("Скопированый текст: " + copyText.value);
          }
        </script>