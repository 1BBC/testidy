<tr> 
  <td>%COUNT%.</td>
  <td><a data-toggle="modal" data-target="#modal%ID%">%NAME%</a></td>
  <td><a href="?create_result=%ID%"><span class="badge bg-red">%COUNT_TESTS_RESULT%</span></a></td>
  <td><a href="?create_questions=%ID%""><span class="badge bg-green">%COUNT_TESTS_QUESTIONS%</span></a></td>
  <td><a data-toggle="modal" data-target="#modal_tags%ID%"><span class="badge bg-yellow">%COUNT_TESTS_TAGS%</span></a></td>
<!--   <td>
    <a href="">
        <div class="progress progress-xs">
            <div class="progress-bar progress-bar-danger" style="width: %RESULT%%"></div>
        </div>
      </a>
  </td>
  <td>%DATE%</td> -->
  <td class="text-center">
    <a class="" data-toggle="modal" data-target="#modal-link%ID%"><i class="text-right glyphicon glyphicon-link"></i></a>
    <a class="text-danger" data-toggle="modal" data-target="#modal-danger%ID%"><i class="text-right glyphicon glyphicon-trash"></i></a>
  </td>
</tr>