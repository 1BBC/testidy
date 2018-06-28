   <body class="layout-top-nav skin-green" style="height: auto; min-height: 100%;">
    <div class="wrapper" style="height: auto; min-height: 100%;">

  <header class="main-header">
    <nav class="navbar navbar-static-top">
      <div class="container">
        <div class="navbar-header">
          <a href="#" class="navbar-brand"><b>Tes</b>TIDY</a> 
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse">
            <i class="fa fa-bars"></i>
          </button>
        </div>
        <!-- Navbar Right Menu -->
        <div class="navbar-custom-menu">
          <ul class="nav navbar-nav">
            <li>
                <div class="pull-left">
                  <a href="/" class="navbar-brand"><span class="glyphicon glyphicon-log-out"></span></a> 
                </div>
            </li>
          </ul>
        </div>
        <!-- /.navbar-custom-menu -->
      </div>
      <!-- /.container-fluid -->
    </nav>
  </header>
    <div class="content-wrapper">
      <!-- <div class="container" style="background-color: black"> -->
        <br>
        <div id="jQuizler" class="main-quiz-holder">
             <h3>%NAME%</h3>
             <div class="alert alert-primary text-left" role="alert">
               %DESCRIPTION%
             </div>
             %URL%
             <link rel="stylesheet" href="/styles/bootstrap.min.css" />
        </div>
      <!-- </div> -->
      <br>
    </div>

      <footer class="main-footer">
        <div class="container">
          <div class="pull-right hidden-xs">
            <b>_{VERSION}_</b> 0.5.2
          </div>
          <strong>_{COPYRIGHT}_ © 2018 </strong> _{DO_STUDENT}_ <a href="http://kpk-lp.com.ua/">КПК НУ «ЛП»</a>. 
        </div>
        <!-- /.container -->
      </footer>
    </div>
    <!-- ./wrapper -->
    </body></html>

    <script type="text/javascript">

        var questions = %JSON_STR%;
    
        jQuery("document").ready(function(){
            jQuery("#jQuizler").jQuizler(questions);
        });

    </script>

    <script type="text/javascript">
        (function(jQuery){
        jQuery.fn.extend({
            jQuizler: function(questions) {

                if (questions == null)
                    throw 'No questions was provided.';

                var reviewQuiz = false;

                var percentage = 0;
                var percentPiece = 100 / questions.length;

                var rightAnswers = 0;
                var rightResult  = "";

                jQuery(this).html("<div class=\"intro\">" + jQuery(this).html() + "</div>");

                jQuery(this).click(function(){
                    jQuery(this).off('click');

                    jQuery(".intro").hide();
                    jQuery(this).css("text-align", "left");
                    jQuery('.progress').css("display", "block");

                    var question = jQuery("#question-1");

                    question.css({opacity : '0', height : '0px'});

                    question.animate({
                        opacity : '1',
                        height : '100%'
                    }, 500, function(e){});

                    question.css('display', 'block');

                    percentage += percentPiece;
                    jQuery(".progress div").css("width", percentage + "%");
                });

                String.prototype.replaceAll = function (find, replace) {
                    var str = this;
                    return str.replace(new RegExp(find, 'g'), replace);
                };

                return this.each(function(){
                    var html = "";

                    html += "<div class=\"results slide-container question\" style=\"display:none\"></div>";


                    jQuery.each(questions, function(index, question){
                        html += "<div id=\"question-" + (index + 1) + "\" class=\"slide-container question\">";
                        //html += "<div class=\"question-number\">Вопрос " + (index + 1) + ' из ' + questions.length + "</div><div style=\"margin:0px; clear:both\"></div>";

                        html += question.question;
                        html += question.img;

                        var correctAnswers = [];
                        for (var i = 0; i < question.correct.length; i++)
                            correctAnswers.push(question.answers[question.correct[i] - 1]);

                        var correctAnswersNewIndexes = [];
                        for (var i = 0; i < question.correct.length; i++)
                            correctAnswersNewIndexes.push(question.answers.indexOf(correctAnswers[i]));

                        question.correct = correctAnswersNewIndexes;

                        /*for (var i = 0; i < question.correct.length; i++)
                         console.log(question.answers[correctAnswersNewIndexes[i]]);*/

                        html += "<ul class=\"answers\">";

                        for (var i = 0; i < question.answers.length; i++)
                            html += "<li class=\"btn\">" + question.answers[i] + "</li>";


                        html += "</ul>";
                        html += "<div class=\"nav-container\">";

                        html += "<div class=\"notice alert alert-info\">_{SELECT_ANSWER}_</div>";

                        if (index != 0) {
                            html += "<button class=\"prev btn btn-info\"><i class='fa fa-arrow-circle-left'></i> _{PREVIOS_PLS}_</button>";
                        }

                        if (index != questions.length-1) {
                            html += "<button class=\"next btn btn-success\">_{NEXT_PLS}_ <i class='fa fa-arrow-circle-right'></i></button>";
                            html += "<div style=\"clear:both\"></div>";

                        } else {
                            html += "<button class=\"final btn btn-success\">_{RESULT}_ <i class='fa fa-check'></i></button>";
                            html += "<div style=\"clear:both\"></div>";
                        }

                        html += "</div></div>";

                        html += "</div>";
                    });



                    html += "<div class=\"progress progress-info progress-striped\">";
                    html += "<div id=\"percent\" class=\"bar\" style=\"width: 0%;\"></div>";
                    html += "</div>";

                    ///html += "<div style=\"margin:0px; clear:both\"></div>";
                    jQuery(this).append(html);

                    jQuery("div[id*='question-'] li").click(function(){
                        if (!reviewQuiz) {
                            /*jQuery(this).siblings().removeClass("selected");
                            jQuery(this).toggleClass("selected");*/

                            jQuery(this).siblings().removeClass("btn-info");
                            jQuery(this).toggleClass("btn-info");
                        }
                    });



                    jQuery(".final").click(function(e){
                        var div = jQuery(e.target).closest("div[id*='question-']");
                        var userAnswer = div.find("li.btn-info");

                        if (userAnswer.index() == -1 && !reviewQuiz) {
                            var notice = div.find(".notice");
                            notice.css('opacity', '0');

                            notice.animate({
                                opacity: 1
                            }, 500, function(){});

                            div.find(".notice").css('display', 'block');
                        } else if (!reviewQuiz) {
                            div.find(".notice").css('display', 'none');

                            percentage += percentPiece;
                            if (percentage > 100) percentage = 100;
                            jQuery("#percent").css("width", percentage + "%");

                            var resultHTML = "<h3 style=\"text-align: center\">РЕЗУЛЬТАТЫ</h3>";

                            jQuery.each(questions, function(index, question){
                                console.log("Правильные ответы: " + question.correct);

                                var element = jQuery("#question-" + (index+1) + " ul li.btn-info");
                                console.log("Ответ пользователя: " + element.index());

                                if (element.index() == question.correct) {
                                    rightAnswers++;
                                }
                                rightResult += ":" + (element.index());
                            });

                            resultHTML += "<p style=\"margin: 14px 0px\">Вы ответили на " + Math.round(((rightAnswers * 100) / questions.length) * 100) / 100 + "% вопросов. " + questions.length  + "</p>";
                            resultHTML += "<p style=\"margin-top:25px; text-align: center\">RESULT( " + rightResult + " )</p>";
                            window.location.replace("%DOMEN_NAME%/?test=%TEST_ID%&result=" + rightResult);
                            // location.href = "&result=" + rightResult;
                            div.animate({
                                opacity : '0'
                            }, 500, function(e){
                                div.css('display', 'none');
                                div.find(".notice").css('display', 'none');

                                jQuery(".results").append(resultHTML);
                                jQuery(".results").css("opacity", "0");
                                jQuery(".results").css("display", "block");

                                jQuery(".results").animate({
                                    opacity : '1'
                                }, 500, function(e){
                                });
                            });

                            jQuery(".progress").animate({
                                opacity : '0'
                            }, 100, function(e){});

                            reviewQuiz = true;
                        }

                        return false;
                    });

                    jQuery(".next").click(function(e){
                        var div = jQuery(e.target).closest("div[id*='question-']");
                        var userAnswer = div.find("li.btn-info");

                        if (userAnswer.index() == -1 && !reviewQuiz) {
                            var notice = div.find(".notice");
                            notice.css('opacity', '0');

                            notice.animate({
                                opacity: 1
                            }, 500, function(){});

                            div.find(".notice").css('display', 'block');
                        } else {

                            var nextId = parseInt(div.attr('id').replace('question-', '')) + 1;
                            //console.log(nextId);

                            var newQuestion = jQuery("#question-" + nextId);

                            div.animate({
                                opacity : '0'
                            }, 500, function(e){
                                div.css('display', 'none');
                                div.find(".notice").css('display', 'none');

                                newQuestion.css({opacity : '0', height : '0px'});

                                newQuestion.animate({
                                    opacity : '1',
                                    height : '100%'
                                }, 500, function(e){});

                                newQuestion.css('display', 'block');
                            });

                            percentage += percentPiece;
                            jQuery(".progress div").css("width", percentage + "%");
                        }

                        return false;
                    });

                    jQuery(".prev").click(function(e){
                        var div = jQuery(e.target).closest("div[id*='question-']");

                        var prevId = parseInt(div.attr('id').replace('question-', '')) - 1;

                        var newQuestion = jQuery("#question-" + prevId);

                        div.animate({
                            opacity : '0'
                        }, 500, function(e){
                            div.css('display', 'none');
                            //div.find(".notice").css('display', 'none');

                            newQuestion.css({opacity : '0', height : '0px'});

                            newQuestion.animate({
                                opacity : '1',
                                height : '100%'
                            }, 500, function(e){});

                            newQuestion.css('display', 'block');
                        });

                        percentage -= percentPiece;
                        jQuery(".progress div").css("width", percentage + "%");

                        return false;
                    });

                    jQuery(".results").click(function(e){
                        jQuery(".results").animate({opacity: 0}, 500, function(e){
                            jQuery(".results").css("display", "none");

                            var question = jQuery("#question-1");

                            question.css({opacity : '0', height : '0px'});

                            question.animate({
                                opacity : '1',
                                height : '100%'
                            }, 500, function(e){});

                            question.css('display', 'block');

                            jQuery(".progress div").css("width", "0");
                            jQuery(".progress div").css("display", "block");
                            jQuery(".progress").animate({
                                opacity : '1'
                            }, 300, function(e){
                                percentage = 0;
                                percentage += percentPiece;
                                jQuery(".progress div").css("width", percentage + "%");
                            });
                         });
                    });
                });
            }
        });


    })(jQuery);
    </script>

    <style type="text/css">

            .main-quiz-holder {
            text-align: center;
        }

        .main-quiz-holder  .slide-container ul.answers {
            margin: 0px;
            list-style: none;
        }

        .main-quiz-holder .slide-container ul.answers li {
            cursor: pointer;
            padding: 6px 30px;
            margin: 10px 0;
            display: block;
            text-align: left;
        }

        .question {
            display: none;
        }

        .main-quiz-holder {
            margin: 0px auto;
            padding: 20px 0px;
            border: 1px solid #dedede;
            width: 600px;
        }

        .main-quiz-holder .slide-container {
            margin: 0px auto;
            width: 500px;
        }

        .main-quiz-holder .question {
            padding-left: 5px;
            line-height: 1.3em;
        }

        .main-quiz-holder .notice {
            display: none;
            text-align: center;
            margin: 0px 0px 15px 0px;
        }

        .nav-container {
            margin: 15px 0px;
        }

        .content-wrapper {
            /*transform: scale(0.67);*/
        }

        .progress {
            margin: 0px auto;
            width: 500px;
            height: 25px;
        }

        .nav-container button.btn-success {
            float: right;
        }

        .results button.btn-success, .results button.btn-danger {
            margin: 3px;
        }

        .results * {
            margin: 0px auto;
        }

        .progress {
            display: none;
        }

        #jQuizler {
            background-color: white;
        }
    </style>
    
