        <div class="modal fade" id="modal%ID%" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">_{CHG_QUESTION}_ №%COUNT%</h4>
              </div>
              <div class="modal-body">
                <form>
                  <input name="create_questions" type="hidden" value="%TEST_ID%">
                  <input name="chg" type="hidden" value="yes">
                  <input name="id"  type="hidden" value="%ID%">
                   <div class="form-group">
                     <label for="recipient-name" class="control-label">_{NAME}_:</label>
                     <input type="text" class="form-control" value="%NAME%" name="name">
                   </div>
                   <div class="form-group">
                     <label for="recipient-name" class="control-label">URL:</label>
                     <input type="text" class="form-control" value="%URL%" name="url">
                   </div>
                   <div class="form-group">
                     <label for="message-text" class="control-label">_{DESCRIPTION}_:</label>
                     <textarea class="form-control" rows="7" name="description">%DESCRIPTION%</textarea>
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
                <h4 class="modal-title">_{DEL_QUESTION}_ №%COUNT%</h4>
              </div>
              <div class="modal-body">
                <p>_{DEL_OK}_</p>

                <div class="form-group">
                  <label for="recipient-name" class="control-label">_{DEL_OK}_:</label>
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
                  <input name="create_questions" type="hidden" value="%TEST_ID%">
                  <button type="submit" class="btn btn-outline">_{DEL}_</button>
                </form>
              </div>
            </div>
            <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog -->
        </div>

        <div class="modal fade" id="modal_answers%ID%" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">_{ANSWERS}_</h4>
              </div>
              <div class="modal-body bg-gray">
                <form id="formet%ID%">
                  <input name="create_questions" type="hidden" value="%TEST_ID%">
                  <input name="questions_id" type="hidden" value="%ID%">
                  <input name="add_answer" type="hidden" value="yes">
                  
                  %FORM_ANSWERS% 
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">_{CLOSE}_</button>
                <button type="submit" class="btn btn-success">_{CHG}_</button>
                </form>
              </div>
            </div>
          </div>
        </div>

<script type="text/javascript">
  var regex%ID% = /^(.+?)(\d+)/i;
  var cloneIndex%ID% = jQuery(".clonedInput%ID%").length;

  function clone%ID%(){
      jQuery(this).parents(".clonedInput%ID%").clone()
          .appendTo("#formet%ID%")
          .attr("id", "clonedInput%ID%" +  cloneIndex%ID%)
          .find("*")
          .each(function() {
              var id = this.id || "";
              var match = id.match(regex%ID%) || [];
              if (match.length == 3) {
                  this.id = match[1] + (cloneIndex%ID%);
              }
          })
          .on('click', 'a.clone%ID%', clone%ID%)
          .on('click', 'a.remove%ID%', remove%ID%);
      cloneIndex%ID%++;
  }
  function remove%ID%(){
      jQuery(this).parents(".clonedInput%ID%").remove();
  }
  jQuery("a.clone%ID%").on("click", clone%ID%);

  jQuery("a.remove%ID%").on("click", remove%ID%);
</script>
