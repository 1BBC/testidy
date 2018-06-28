#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

our (%conf, %lang, @MONTHES, @WEEKDAYS);


BEGIN {
  unshift(@INC, '../language/',
    '../lib',
    '../mysql',
  );
}

use Abills::Base;
use Abills::HTML;
use Time::Piece;
use Abills::Defs qw\$DATE\;
use Users;
use Tests;

do "../config/config.pl";
if(!%conf){
  print "Error: Can't load config file 'config.pl'\n";
  exit;
}

our $html = Abills::HTML->new(
  {
    IMG_PATH => 'img/',
    NO_PRINT => 1,
    CONF     => \%conf,
    CHARSET  => $conf{default_charset},
  }
);
my $t   = localtime;
my $UID = 0;
our $db = Abills::SQL->connect($conf{dbtype}, $conf{dbhost}, $conf{dbname}, $conf{dbuser}, $conf{dbpasswd}, { CHARSET => ($conf{dbcharset}) ? $conf{dbcharset} : undef });
require Abills::Templates;

my $Users = Users->new($db, \%conf);
my $Tests = Tests->new($db, \%conf);

my $cookies = $html->get_cookies();
if(($FORM{login} && $FORM{password} && $FORM{logined}) || $FORM{signout}){
  $html->set_cookies('login',    $FORM{login},    "Fri, 1-Jan-2038 00:00:01", '192.168.1.100');
  $html->set_cookies('password', $FORM{password}, "Fri, 1-Jan-2038 00:00:01", '192.168.1.100');
  $cookies->{login}    = $FORM{login};
  $cookies->{password} = $FORM{password};
}

if($FORM{lng}){
  $html->set_cookies('lng', $FORM{lng}, "Fri, 1-Jan-2038 00:00:01", '192.168.1.100');
  $cookies->{lng} = $FORM{lng};
}

if($cookies->{lng}){
  do "../languages/$cookies->{lng}.pl";
}
else{
  do "../languages/ukrainian.pl";
}



$html->{METATAGS} = templates('main_header');
print $html->header();

if($FORM{registration}){
  my $message_text = ();
  if($FORM{end_registration}){
    if($FORM{password} ne $FORM{repeat_password}){
      $message_text = "$lang{BAD_PASSWORDS}\n";
    }
    my $user_check_login = $Users->list(
      { 
        COLS_NAME => 1, 
        PAGE_ROWS => 1, 
        LOGIN     => $FORM{login}, 
      }
    );
    if($user_check_login){
      $message_text .= "$lang{USER} @" . "$FORM{login} $lang{EXIST}\n";
    }
    my $user_check_email = $Users->list(
      { 
        COLS_NAME => 1, 
        PAGE_ROWS => 1, 
        EMAIL     => $FORM{email}, 
      }
    );
    if($user_check_email){
      $message_text .= "$lang{MAIL} $FORM{email} $lang{CANT_USE}\n";
    }
    if(!$message_text){
      $Users->add(
        {
          LOGIN     => $FORM{login},
          USERNAME  => $FORM{username},
          PASSWORD  => $FORM{password},
          DATE_REG  => $t->ymd,
          EMAIL     => $FORM{email},
        }
      );
      print $html->tpl_show(templates('registration_succes'), 
        { 
          message  => $html->message('info', $lang{OK}, "$lang{REG_FOR_USER} @". $FORM{login} . " $lang{GOOD_END_REG}"),
        }
      );
      exit;
    }
  }
  my $message = ($message_text) ? $html->message('err', "$lang{ERROR}", "$message_text") : q{<p class="login-box-msg">$lang{REG_NEW_ACC}</p>};

  print $html->tpl_show(templates('registration'), 
    { 
      message  => $message,
      login    => $FORM{login}, 
      password => $FORM{password},
      email    => $FORM{email},
      username => $FORM{username},
      DOLLAR   => '$',
    }
  );
  exit;
}
# $Users->{debug} = 1;

my $user_header_tpl          = $html->tpl_show(templates('header_user_not_registered'),{login => $FORM{login}, password => $FORM{password}});
my $create_tools_tpl         = '';
my $registration_err_message = '';
my $body_tpl                 = '';
my $active_faq               = '';
my $active_tests             = '';
my $active_users             = '';
my $active_tags              = '';
if($cookies->{login} && $cookies->{password}){
  my $user_sign_info = $Users->list(
    { 
      COLS_NAME => 1, 
      PAGE_ROWS => 1, 
      LOGIN     => $cookies->{login}, 
      PASSWORD  => $cookies->{password},
    }
  );

  if($user_sign_info){
    $UID = $user_sign_info->[0]->{id};
    my Time::Piece $d = Time::Piece->strptime($user_sign_info->[0]->{date_reg}, "%Y-%m-%d");
    $d->day_list(@WEEKDAYS);
    $d->mon_list(@MONTHES);

    my $user_block = '';
    if($FORM{viewd_message}){
      $Tests->update_views(
        { 
          USER => $UID,
        }
      );
    }
    my $list_comments = $Tests->list_comments(
      { 
        COLS_NAME => 1, 
        PAGE_ROWS => 1, 
        USER      => $UID,
        VIEWED    => 0,
      }
    );
    my $count_list_comments = 0;
    if($list_comments){
      foreach my $comment (@$list_comments){
        $count_list_comments++;
        my $list_tests = $Tests->list_tests(
          { 
            ID => $comment->{test_id}, 
          }
        );

        my $list_user = $Users->list(
          { 
            ID => $comment->{user}, 
          }
        );
        my $user_url = (length($list_user->[0]->{url})>5) ? $list_user->[0]->{url} : 'http://citizen.edisha.gov.in/Content/assets/stylesheet/img/placeholder-user.png';

        $user_block .= $html->tpl_show(templates('header_user_registered_user_block'), 
          {
            URL       => $user_url,   
            NAME      => $list_user->[0]->{login},
            UID       => $comment->{user},
            COMMENT   => $comment->{comment},
            TEST_ID   => $comment->{test_id},
            TEST_NAME => $list_tests->[0]->{name}
          }
        );
      }
    }

    my $count_message    = ($count_list_comments>0) ? $count_list_comments : "Нет";
    my $user_url = (length($user_sign_info->[0]->{url})>5) ? $user_sign_info->[0]->{url} : 'http://citizen.edisha.gov.in/Content/assets/stylesheet/img/placeholder-user.png';
    $count_list_comments = ($count_list_comments>0) ? "$lang{IN_YOU} $count_list_comments $lang{NEW_MES}" : "$lang{IN_YOU} $lang{NOUP} $lang{NEW_MES}";
    
    $user_header_tpl = $html->tpl_show(templates('header_user_registered'), 
      {
        COUNT_MESSAGE_INFO => $count_list_comments,
        COUNT_MESSAGE      => $count_message,
        LOGIN              => $user_sign_info->[0]->{login},
        USERNAME           => $user_sign_info->[0]->{username},
        URL                => $user_url,
        DATE_REG           => $lang{IN_SITE_FROM} . ' ' . $d->wdayname . ', ' . $d->mday . ' ' . $d->monname . ' ' .  $d->year,
        USER_BLOCK         => $user_block,
      }
    );

    $create_tools_tpl = $html->tpl_show(templates('header_create_tools'));
  }
  elsif($FORM{login} || $FORM{password}){
    $registration_err_message = $html->message('err', $lang{ERROR}, "$lang{NO_EXIST_LOG_OR_PASS} " . "<a href='/?registration=yes' style='color: white;'>$lang{REGISTRATION}.</a>");
  }

  if($FORM{create_test} || $FORM{create_result} || $FORM{create_questions} || $FORM{create_new_test}){
    $create_tools_tpl = $html->tpl_show(templates('header_create_tools'), {ACTIVE_CREATE_TEST => 'active'});
  }

  if($FORM{tests}){
    $active_tests = 'active';
  }

  if($FORM{tags} || $FORM{tag}){
    $active_tags = 'active';
  }
}


if($FORM{FAQ}){
  $active_faq = 'active';
  $body_tpl = $html->tpl_show(templates('form_FAQ'));
}

elsif($FORM{test} && !$FORM{result}){

  my @test_arr   = ();
  my $list_tests = $Tests->list_tests(
    { 
      COLS_NAME => 1, 
      PAGE_ROWS => 1, 
      ID        => $FORM{test}, 
    }
  );
  exit if (!$list_tests);
  my $test = $list_tests->[0];

  my $list_tests_questions = $Tests->list_tests_questions(
    { 
      COLS_NAME => 1, 
      PAGE_ROWS => 1, 
      TEST_ID   => $FORM{test}, 
    }
  );

  foreach my $question (@$list_tests_questions){
    my %question_hash  = ();
    my @answers = ();
    my $list_tests_answers = $Tests->list_tests_answers(
      { 
        COLS_NAME   => 1, 
        PAGE_ROWS   => 1, 
        TEST_ID     => $FORM{test}, 
        QUESTION_ID => $question->{id},
      }
    );

    foreach my $answer (@$list_tests_answers){
      push @answers, $answer->{name};
    }
    $question->{description} = (length($question->{description})>1) ? "<div class='alert alert-primary' role='alert'>$question->{description}</div>" : '';
    $question_hash{question} = "<h3>$question->{name}</h3>$question->{description}";
    $question_hash{img}      = (length($question->{url})>5) ? "<div class='text-center'><img src='$question->{url}' class='rounded' alt='$question->{name}'></div>" : "";
    $question_hash{answers}  = [@answers];
    $question_hash{correct}  = ['1'];
    push @test_arr, \%question_hash;
  }

  my $json_str = _json_former(\@test_arr);
  my $test_url = (length($test->{url})>5) ? "<div><img src='$test->{url}' alt='$test->{name}'></div>" : '';
  print $html->tpl_show(templates('test'), 
    {
      JSON_STR    => $json_str,
      NAME        => $test->{name},
      DESCRIPTION => $test->{description},
      URL         => $test_url, 
      TEST_ID     => $FORM{test},
      DOMEN_NAME  => $conf{domen_name},
    }
  );
  exit;
}

print $html->tpl_show(templates('header'), 
  { 
    SERVER_NAME               => $ENV{SERVER_NAME}, 
    USER_HEADER_TPL           => $user_header_tpl,
    CREATE_TOOLS              => $create_tools_tpl,
    REGISTRATION_ERR_MESSAGE  => $registration_err_message,
    BODY_TPL                  => $body_tpl,
    ACTIVE_FAQ                => $active_faq,
    ACTIVE_TESTS              => $active_tests,
    ACTIVE_USERS              => $active_users,
    ACTIVE_TAGS               => $active_tags,
  }
);

if($FORM{create_test} && $UID){

  my $rows       = '';
  my $modals     = '';

  if($FORM{chg}){

    $Tests->change_tests(
      {
        ID           => $FORM{id},
        NAME         => $FORM{name},
        URL          => $FORM{url},
        DESCRIPTION  => $FORM{description},
      }
    );
  }

  if($FORM{chg_tags}){

    $Tests->del_tests_tags($FORM{chg_tags});

    my @tags = split(',', $FORM{tags});

    foreach my $tag (@tags){
      $tag =~ s/\s//;
      next if(length($tag) < 3);

      my $list_tags = $Tests->list_tags(
        {
          NAME => $tag,
        }
      );
      if($list_tags){
        $Tests->add_tests_tags(
          {
            TEST_ID => $FORM{chg_tags},
            TAG_ID  => $list_tags->[0]->{id},
          }
        );
      }
      else{
        my $add_tag_info = $Tests->add_tags(
          {
            NAME => $tag,
          }
        );

        $Tests->add_tests_tags(
          {
            TEST_ID => $FORM{chg_tags},
            TAG_ID  => $add_tag_info->{INSERT_ID},
          }
        );
      }
    }
  }

  if($FORM{del}){
    $Tests->del_tests($FORM{del});
  }

  my $list_tests = $Tests->list_tests(
    { 
      COLS_NAME => 1, 
      PAGE_ROWS => 1, 
      UID       => $UID, 
    }
  );

  my $count = 0;
  foreach my $test_info (@$list_tests){
    $count++;

    my $list_tests_result = $Tests->list_tests_result(
      { 
        COLS_NAME => 1, 
        PAGE_ROWS => 1, 
        TEST_ID   => $test_info->{id},
      }
    );


    my $count_tests_questions = $Tests->count_tests_questions(
      { 
        COLS_NAME => 1, 
        PAGE_ROWS => 1, 
        TEST_ID   => $test_info->{id},
      }
    );

    my $count_tests_result = $Tests->count_tests_result(
      { 
        COLS_NAME => 1, 
        PAGE_ROWS => 1, 
        TEST_ID   => $test_info->{id},
      }
    );

    my $count_tests_tags = $Tests->count_tests_tags(
      { 
        COLS_NAME => 1, 
        PAGE_ROWS => 1, 
        TEST_ID   => $test_info->{id},
      }
    );

    my $list_tests_tags = $Tests->list_tests_tags(
      { 
        COLS_NAME => 1, 
        PAGE_ROWS => 1, 
        TEST_ID   => $test_info->{id}, 
      }
    );

    my $tags_row = '';
    foreach my $tests_tags (@$list_tests_tags){
      my $list_tags = $Tests->list_tags(
        { 
          COLS_NAME => 1, 
          PAGE_ROWS => 1, 
          ID        => $tests_tags->{tag_id}, 
        }
      );

      $tags_row .= $html->tpl_show(templates('form_create_test_tags_row'),
        {
          TAG_NAME => $list_tags->[0]->{name},
        }
      );
    }

    $rows .= $html->tpl_show(templates('form_create_test_row'),
      {
        ID                    => $test_info->{id},
        NAME                  => $test_info->{name},
        COUNT                 => $count,
        DATE                  => $test_info->{date},
        RATING                => $test_info->{rating},
        COUNT_TESTS_QUESTIONS => $count_tests_questions->[0]->{'COUNT(*)'},
        COUNT_TESTS_RESULT    => $count_tests_result->[0]->{'COUNT(*)'},
        COUNT_TESTS_TAGS      => $count_tests_tags->[0]->{'COUNT(*)'},
      });

    $modals .= $html->tpl_show(templates('form_create_test_modal'),
      {
        ID                    => $test_info->{id},
        NAME                  => $test_info->{name},
        COUNT                 => $count,
        TAGS_ROW              => $tags_row,
        URL                   => $test_info->{url},
        DOMEN_NAME            => $conf{domen_name},
        DESCRIPTION           => $test_info->{description},
      }); 
  }

  print $html->tpl_show(templates('form_create_test'),{ROWS => $rows, MODALS => $modals});
}

elsif($FORM{create_result}){
  my $rows         = '';
  my $modals       = '';
  my @range_letter = ('A', 'B', 'C', 'D', 'E', 'F');
  my @range_color  = ('green', 'yellow', 'blue', 'red', 'aqua', 'null');

  if($FORM{chg}){

    $Tests->change_tests_result(
      {
        ID           => $FORM{id},
        NAME         => $FORM{name},
        URL          => $FORM{url},
        DESCRIPTION  => $FORM{description},
      }
    );
  }

  if($FORM{add}){

    $Tests->add_tests_result(
      {
        TEST_ID      => $FORM{create_result},
        NAME         => $FORM{name},
        URL          => $FORM{url},
        DESCRIPTION  => $FORM{description},
      }
    );
  }

  if($FORM{del}){

    $Tests->del_tests_result($FORM{del});
  }

  my $list_tests_result = $Tests->list_tests_result(
    { 
      COLS_NAME => 1, 
      PAGE_ROWS => 1, 
      UID       => $UID, 
      TEST_ID   => $FORM{create_result}
    }
  );

  my $count = 0;

  foreach my $result_info (@$list_tests_result){
    
    $count++;
    $rows .= $html->tpl_show(templates('form_create_test_result_row'),
      {
        ID     => $result_info->{id},
        NAME   => $result_info->{name},
        COUNT  => $count,
        COLOR  => $range_color[$count-1],
        LETTER => $range_letter[$count-1],
      });

    $modals .= $html->tpl_show(templates('form_create_test_result_modal'),
      {
        TEST_ID     => $FORM{create_result},
        ID          => $result_info->{id},
        NAME        => $result_info->{name},
        COUNT       => $count,
        URL         => $result_info->{url},
        DESCRIPTION => $result_info->{description},
      }); 
  }

  print $html->tpl_show(templates('form_create_test_result'),{ROWS => $rows, MODALS => $modals, TEST_ID => $FORM{create_result}});
}

elsif($FORM{create_questions}){
  my $rows        = '';
  my $modals      = '';
  my @range_color = ('success', 'warning', 'primary', 'danger', 'info', 'null');
  my @range_letter = ('A', 'B', 'C', 'D', 'E', 'F');

  if($FORM{chg}){

    $Tests->change_tests_questions(
      {
        ID           => $FORM{id},
        NAME         => $FORM{name},
        URL          => $FORM{url},
        DESCRIPTION  => $FORM{description},
      }
    );
  }

  if($FORM{add}){

    $Tests->add_tests_questions(
      {
        TEST_ID      => $FORM{create_questions},
        NAME         => $FORM{name},
        URL          => $FORM{url},
        DESCRIPTION  => $FORM{description},
      }
    );
  }

  if($FORM{del}){
    $Tests->del_tests_questions($FORM{del});
  }

  if($FORM{add_answer}){

    $Tests->del_tests_answers($FORM{questions_id});

    if($FORM{questions} && $FORM{answers_value}){
      my @questions     = split(',', $FORM{questions});
      my @answers_value = split(',', $FORM{answers_value});

      foreach my $question (@questions){
        my $add_info = $Tests->add_tests_answers(
          {
            TEST_ID      => $FORM{create_questions},
            QUESTION_ID  => $FORM{questions_id},
            NAME         => $question,
          }
        );
        my $answers_id = $add_info->{INSERT_ID};

        my $list_tests_result = $Tests->list_tests_result(
          { 
            COLS_NAME => 1, 
            PAGE_ROWS => 1, 
            TEST_ID   => $FORM{create_questions},
          }
        );

        foreach my $tests_result (@$list_tests_result)
        {
          my $value = shift @answers_value;

          $Tests->add_tests_answers_value(
            {
              TEST_ID      => $FORM{create_questions},
              QUESTION_ID  => $FORM{questions_id},
              RESULT_ID    => $tests_result->{id},
              ANSWERS_ID   => $answers_id,
              VALUE        => $value,
            }
          );
        }
      }
    }
  }

  my $list_tests_questions = $Tests->list_tests_questions(
    { 
      COLS_NAME => 1, 
      PAGE_ROWS => 1, 
      UID       => $UID, 
      TEST_ID   => $FORM{create_questions}
    }
  );

  my $count = 0;

  foreach my $questions (@$list_tests_questions){

    $count++;
    my $form_answers = '';

    my $list_tests_answers = $Tests->list_tests_answers(
      { 
        COLS_NAME   => 1, 
        PAGE_ROWS   => 1, 
        QUESTION_ID => $questions->{id}, 
        TEST_ID     => $FORM{create_questions}
      }
    );
    # _bp('', $list_tests_answers);
    my $answers_row = '';

    if(!$list_tests_answers){

      my $count_tests_result = $Tests->count_tests_result(
        { 
          TEST_ID     => $FORM{create_questions},
        }
      );

      foreach my $i (1..$count_tests_result->[0]->{'COUNT(*)'})
      {
        $answers_row .= $html->tpl_show(templates('form_create_test_answers_row'),
          {
            VALUE => 0,
            RANGE_COLOR => $range_color[$i-1], 
            RANGE_LETTER => $range_letter[$i-1],
          }
        );
      }

      $form_answers .= $html->tpl_show(templates('form_create_test_answers'),
        {
          QUESTION_ID  => $questions->{id},
          ANSWERS_ROW  => $answers_row,
          ANSWERS_NAME => '',
        }
      );
    }

    foreach my $answers (@$list_tests_answers){

      $answers_row = '';

      my $list_tests_result = $Tests->list_tests_result(
        { 
          COLS_NAME   => 1, 
          PAGE_ROWS   => 1, 
          TEST_ID     => $FORM{create_questions}
        }
      );
      # _bp('', $list_tests_result);
      my $result_count = 0;

      foreach my $result (@$list_tests_result){
        my $list_tests_answers_value = $Tests->list_tests_answers_value(
          { 
            COLS_NAME   => 1, 
            PAGE_ROWS   => 1, 
            RESULT_ID   => $result->{id},
            QUESTION_ID => $questions->{id}, 
            ANSWERS_ID  => $answers->{id}, 
            TEST_ID     => $FORM{create_questions}
          }
        );

        # _bp('', $list_tests_answers_value);

        $answers_row .= $html->tpl_show(templates('form_create_test_answers_row'),
          {
            VALUE       => ($list_tests_answers_value->[0]->{value} || 0),
            QUESTION_ID => $answers->{id},
            RANGE_COLOR => $range_color[$result_count], 
            RANGE_LETTER => $range_letter[$result_count],
          }
        );
        $result_count++;
      }

      $form_answers .= $html->tpl_show(templates('form_create_test_answers'),
        {
          QUESTION_ID  => $questions->{id},
          ANSWERS_ROW  => $answers_row,
          ANSWERS_NAME => $answers->{name},
        }
      );

    }

    my $count_tests_answers = $Tests->count_tests_answers(
      { 
        COLS_NAME   => 1, 
        PAGE_ROWS   => 1, 
        QUESTION_ID => $questions->{id}, 
        TEST_ID     => $FORM{create_questions}
      }
    );

    $rows .= $html->tpl_show(templates('form_create_test_questions_row'),
      {
        ID                   => $questions->{id},
        NAME                 => $questions->{name},
        COUNT                => $count,
        COUNT_TESTS_ANSWERS  => $count_tests_answers->[0]->{'COUNT(*)'},
      });

    $modals .= $html->tpl_show(templates('form_create_test_questions_modal'),
      {
        TEST_ID               => $FORM{create_questions},
        ID                    => $questions->{id},
        NAME                  => $questions->{name},
        COUNT                 => $count,
        URL                   => $questions->{url},
        DESCRIPTION           => $questions->{description},
        FORM_ANSWERS          => $form_answers,
      }); 
  }

  print $html->tpl_show(templates('form_create_test_questions'),{ROWS => $rows, MODALS => $modals, TEST_ID => $FORM{create_questions}, TEXT => '.clonedInput'});
}

elsif($FORM{create_new_test} && $UID){

  if($FORM{create_new_results}){

    my $add_test_info = $Tests->add_tests(
      { 
        NAME        => $FORM{name},
        URL         => $FORM{url}, 
        DESCRIPTION => $FORM{description}, 
        UID         => $UID, 
        DATE        => $t->ymd,
      }
    );

    my $test_id = $add_test_info->{INSERT_ID};
    my @tags = split(',', $FORM{tags});

    foreach my $tag (@tags){

      $tag =~ s/\s//;
      next if(length($tag) < 2);

      my $list_tags = $Tests->list_tags(
        {
          NAME => $tag,
        }
      );
      if($list_tags){
        $Tests->add_tests_tags(
          {
            TEST_ID => $test_id,
            TAG_ID  => $list_tags->[0]->{id},
          }
        );
      }
      else{
        my $add_tag_info = $Tests->add_tags(
          {
            NAME => $tag,
          }
        );

        $Tests->add_tests_tags(
          {
            TEST_ID => $test_id,
            TAG_ID  => $add_tag_info->{INSERT_ID},
          }
        );
      }
    }
    print $html->tpl_show(templates('form_create_new_test_results'), {TEST_ID => $test_id});
  }
  elsif($FORM{create_new_questions}){

    my @name         = split(',', $FORM{name});
    my @description  = split(',', $FORM{description});
    my @url          = split(',', $FORM{url});
    my $answers_row  = '';
    my $result_count = '';
    my @range_color  = ('success', 'warning', 'primary', 'danger', 'info', 'null');
    my @range_letter = ('A', 'B', 'C', 'D', 'E', 'F');

    foreach my $i (0..5){

      last if (length($name[$i]) < 2);

      $Tests->add_tests_result(
        {
          TEST_ID      => $FORM{test_id},
          NAME         => $name[$i],
          DESCRIPTION  => $description[$i],
          URL          => $url[$i],
        }
      );
      $result_count++;
    }

    foreach my $i (1..$result_count){
      $answers_row .= $html->tpl_show(templates('form_create_test_answers_row'), 
        {
          VALUE => 0,
          RANGE_COLOR => $range_color[$i-1], 
          RANGE_LETTER => $range_letter[$i-1],
        }
      );
    }
    print $html->tpl_show(templates('form_create_new_test_question'), {TEST_ID => $FORM{test_id}, ANSWERS_ROW => $answers_row });
  }
  elsif($FORM{create_new_question}){

    my @answers       = split(',', $FORM{answers});
    my @answers_value = split(',', $FORM{answers_value});
    my @range_color   = ('success', 'warning', 'primary', 'danger', 'info', 'null');
    my @range_letter  = ('A', 'B', 'C', 'D', 'E', 'F');

    my $add_question_info = $Tests->add_tests_questions(
      {
        TEST_ID      => $FORM{test_id},
        NAME         => $FORM{name},
        URL          => $FORM{url},
        DESCRIPTION  => $FORM{description},
      }
    );
    my $question_id = $add_question_info->{INSERT_ID};

    foreach my $answer (@answers){
      my $add_info = $Tests->add_tests_answers(
        {
          TEST_ID      => $FORM{test_id},
          QUESTION_ID  => $question_id,
          NAME         => $answer,
        }
      );
      my $answers_id = $add_info->{INSERT_ID};

      my $list_tests_result = $Tests->list_tests_result(
        { 
          COLS_NAME => 1, 
          PAGE_ROWS => 1, 
          TEST_ID   => $FORM{test_id},
        }
      );

      foreach my $tests_result (@$list_tests_result)
      {
        my $value = shift @answers_value;

        $Tests->add_tests_answers_value(
          {
            TEST_ID      => $FORM{test_id},
            QUESTION_ID  => $question_id,
            RESULT_ID    => $tests_result->{id},
            ANSWERS_ID   => $answers_id,
            VALUE        => $value,
          }
        );
      }
    }

    my $result_count = $Tests->count_tests_result(
      { 
        COLS_NAME => 1, 
        PAGE_ROWS => 1, 
        TEST_ID   => $FORM{test_id},
      }
    );
    my $answers_row = '';
    foreach my $i (1..$result_count->[0]->{'COUNT(*)'}){
      $answers_row .= $html->tpl_show(templates('form_create_test_answers_row'), 
        {
          VALUE => 0,
          RANGE_COLOR => $range_color[$i-1], 
          RANGE_LETTER => $range_letter[$i-1],
        }
      );
    }
    if($FORM{create_mod_of}){
      print $html->tpl_show(templates('form_create_new_test_end'), {TEST_ID => $FORM{test_id}, ANSWERS_ROW => $answers_row, DOMEN_NAME => $conf{domen_name}});
    }
    else{
      print $html->tpl_show(templates('form_create_new_test_question'), {TEST_ID => $FORM{test_id}, ANSWERS_ROW => $answers_row});
    }
    
  }
  else{
    print $html->tpl_show(templates('form_create_new_test'), {DOLLAR => '$'});
  }
  
}

#**********************************************************
=head2 RESULT FORM

=cut
#**********************************************************
elsif($FORM{result} && $FORM{test}){
  my @range_color     = ('green', 'yellow', 'blue', 'red', 'aqua', 'null');
  my $message         = '';
  my $report_message  = '';
  my $like_message    = '';
  my $comment_message = '';
  my $like_btns       = "<button type='submit' class='btn btn-secondary btn-lg' name='like' value='yes'><i class='fa fa-thumbs-up'></i> $lang{LIKE}</button><button type='submit' class='btn btn-secondary btn-lg' name='dislike' value='yes'><i class='fa fa-thumbs-down'></i> $lang{DISLIKE}</button>";
  my $rating          = 0;

  my $list_tests = $Tests->list_tests(
    { 
      COLS_NAME => 1, 
      PAGE_ROWS => 1, 
      ID        => $FORM{test}, 
    }
  );

  if(!$list_tests){
    print $html->message('err', $lang{ERROR}, "$lang{TEST_NO_EXIST}");
    exit;
  }

  my $test_user = $Users->list(
    { 
      COLS_NAME => 1, 
      PAGE_ROWS => 1, 
      ID        => $list_tests->[0]->{uid}, 
    }
  );

  if($FORM{comment}){
    if($UID){
      $Tests->del_comment({TEST_ID => $FORM{test}, UID => $UID, COMMENT => $FORM{comment}});
      $Tests->add_comment({TEST_ID => $FORM{test}, UID => $UID, COMMENT => $FORM{comment}, USER => $list_tests->[0]->{uid}, DATETIME => $t->ymd . " " . $t->hms});
      $comment_message = $html->message('info', "$lang{COMM_IS_ADD}", "$lang{YOU_COMM_IS}");
    }
    else{
      $message = $html->message('warn', "$lang{WARN}", "$lang{NO_REF_USER_CANT}");
    }
  }
  elsif($FORM{del_comment}){
    $Tests->del_comment_id({TEST_ID => $FORM{test}, UID => $UID, ID => $FORM{del_comment}});
    $comment_message = $html->message('info', "$lang{DELETED}", "$lang{COMM_DELETED}");
  }
  elsif($FORM{report_description}){
    if($UID){
      $Tests->del_report({TEST_ID => $FORM{test}, UID => $UID});
      $Tests->add_report({TEST_ID => $FORM{test}, UID => $UID, DESCRIPTION => $FORM{report_description}});
      $report_message = $html->message('info', "$lang{REPPORT_ADD}", "$lang{YOU_COMM_IS}");
    }
    else{
      $message = $html->message('warn', "$lang{WARN}", "$lang{NO_REF_USER_CANT}");
    }
  }
  elsif($FORM{like}){
    if($UID){
      $Tests->del_like({TEST_ID => $FORM{test}, UID => $UID});
      $Tests->add_like({TEST_ID => $FORM{test}, UID => $UID, VALUE => '1'});
      $like_message = $html->message('info', "$lang{YPO_DO_LIKE}", "$lang{YOU_COMM_IS}");
    }
    else{
      $message = $html->message('warn', "$lang{WARN}", "$lang{NO_REF_USER_CANT}");
    }
    
  }
  elsif($FORM{dislike}){
    if($UID){
      $Tests->del_like({TEST_ID => $FORM{test}, UID => $UID});
      $Tests->add_like({TEST_ID => $FORM{test}, UID => $UID});
      $like_message = $html->message('info', "$lang{YPO_DO_LIKE}", "$lang{YOU_COMM_IS}");
    }
    else{
      $message = $html->message('warn', "$lang{WARN}", "$lang{NO_REF_USER_CANT}");
    }
  }

  my $list_likes = $Tests->list_likes(
    { 
      COLS_NAME => 1, 
      PAGE_ROWS => 1,  
      TEST_ID  => $FORM{test}, 
      UID      => $UID,
    }
  );

  if($list_likes){
    if($list_likes->[0]->{value} == 1){
      $like_btns = "<button type='submit' class='btn btn-success btn-lg' name='like' value='yes'><i class='fa fa-thumbs-up'></i> $lang{LIKE}</button><button type='submit' class='btn btn-secondary btn-lg' name='dislike' value='yes'><i class='fa fa-thumbs-down'></i> $lang{DISLIKE}</button>";
    }
    else{
      $like_btns = "<button type='submit' class='btn btn-secondary btn-lg' name='like' value='yes'><i class='fa fa-thumbs-up'></i> $lang{LIKE}</button><button type='submit' class='btn btn-success btn-lg' name='dislike' value='yes'><i class='fa fa-thumbs-down'></i> $lang{DISLIKE}</button>";
    }
  }

  my $full_list_likes = $Tests->list_likes(
    { 
      COLS_NAME => 1, 
      PAGE_ROWS => 1,  
      TEST_ID  => $FORM{test}, 
    }
  );

  foreach my $like (@$full_list_likes){
    if($like->{value} == 1){
      $rating++;
    }
    else{
      $rating--;
    }    
  }
  $rating = ($rating>0) ? "+$rating" : "$rating";

  my $test          = $list_tests->[0];
  my @results       = split(':', $FORM{result}); shift @results;
  my @rusult_values = ();

  $list_tests->[0]->{viewing}++;
  $Tests->update_tests_viewing(
      {  
        ID => $FORM{test},
        VIEWING => $list_tests->[0]->{viewing},
      }
    );

  my $list_tests_questions = $Tests->list_tests_questions(
    { 
      COLS_NAME => 1, 
      PAGE_ROWS => 1,  
      TEST_ID   => $FORM{test}
    }
  );

  my $question_count = 0;
  foreach my $question (@$list_tests_questions){
    my $list_tests_answers = $Tests->list_tests_answers(
      { 
        COLS_NAME   => 1, 
        PAGE_ROWS   => 1, 
        QUESTION_ID => $question->{id}, 
      }
    );

    my $answer_count = 0;
    foreach my $answer (@$list_tests_answers){

      if($answer_count == $results[$question_count]){
        
        my $list_tests_answers_value = $Tests->list_tests_answers_value(
          { 
            COLS_NAME  => 1, 
            PAGE_ROWS  => 1, 
            ANSWERS_ID => $answer->{id},
          }
        );

        my $value_count = 0;
        foreach my $value (@$list_tests_answers_value){
          $rusult_values[$value_count] += $value->{value};
          $value_count++;
        }
      }
       $answer_count++; 
    }
    $question_count++; 

  }

  my $list_tests_result = $Tests->list_tests_result(
    { 
      COLS_NAME => 1, 
      TEST_ID   => $FORM{test},
    }
  );

  my $final_result = 0;
  my $max          = $rusult_values[0];
  my $probability  = '';    

  map {$max=$_ if ($_>$max);} @rusult_values;
  foreach my $i (0..$#rusult_values){
    $probability .= "<label>$list_tests_result->[$i]->{name}</label><div class=\"progress\"><div class=\"progress-bar progress-bar-$range_color[$i]\" role=\"progressbar\" aria-valuenow=\"" . (int(($rusult_values[$i] * 100)/($max+20))) . "\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: " . (int(($rusult_values[$i] * 100)/($max+20))) . "%\"></div></div>";

    if($max <= $rusult_values[$i]){
      $max = $rusult_values[$i];
      $final_result = $i;
    }
  }

  my $list_comments = $Tests->list_comments(
    { 
      COLS_NAME => 1, 
      TEST_ID   => $FORM{test},
    }
  );

  my $comments_block = '';
  foreach my $comment (@$list_comments){

    my $del = '';

    my $user = $Users->list(
      { 
        COLS_NAME => 1, 
        PAGE_ROWS => 1, 
        ID        => $comment->{uid}, 
      }
    );

    if($comment->{uid} == $UID){
      $del = "<a href='/?result=$FORM{result}&test=$FORM{test}&del_comment=$comment->{id}' class='pull-right btn-box-tool'><i class='fa fa-times'></i></a>";
    }
    my $user_url = (length($user->[0]->{url})>5) ? $user->[0]->{url} : 'http://citizen.edisha.gov.in/Content/assets/stylesheet/img/placeholder-user.png';
    $comments_block .= $html->tpl_show(templates('user_block'), 
      {
        USER_URL   => $user_url,
        COMMENT    => $comment->{comment},
        COMMENT_ID => $comment->{id},
        DATETIME   => $comment->{datetime},
        UID        => $comment->{uid},
        USERNAME   => $user->[0]->{username},
        LOGIN      => $user->[0]->{login},
        DEL        => $del,
      }
    );
  }

  my $url = (length($list_tests_result->[$final_result]->{url})>5) ? "<div class='text-center'><img src='$list_tests_result->[$final_result]->{url}'></div>" : '';
  my $description = (length($list_tests_result->[$final_result]->{description})>2) ? $list_tests_result->[$final_result]->{description} : "$lang{TEST_NO_DISCR}";

  print $html->tpl_show(templates('test_result'), 
    {
      DOLLAR          => '$',
      TEST_ID         => $FORM{test},
      TEST_NAME       => $test->{name},
      NAME            => $list_tests_result->[$final_result]->{name},
      URL             => $url,
      DESCRIPTION     => $description,
      DESCR           => $list_tests_result->[$final_result]->{description},
      DOMEN_NAME      => $conf{domen_name},
      PROBABILITY     => $probability,
      VIEWING         => $list_tests->[0]->{viewing},
      RESULT          => $FORM{result},
      LIKE_BTNS       => $like_btns,
      MESSAGE         => $message,
      RATING          => $rating,
      REPORT_MESSAGE  => $report_message,
      LIKE_MESSAGE    => $like_message,
      COMMENTS_BLOCK  => $comments_block,
      COMMENT_MESSAGE => $comment_message,
      TEST_USER_ID    => $test_user->[0]->{id},
      TEST_USERNAME   => $test_user->[0]->{username},
      TEST_USER_LOGIN => $test_user->[0]->{login},
    }
  );
}

#**********************************************************
=head2 MY PRIFILE

=cut
#**********************************************************
elsif($FORM{my_profile} && $UID){

  my $message = '';
  if($FORM{chg_user_info}){

    $Users->change_user_info(
      { 
        ID         => $UID, 
        USERNAME   => $FORM{username},
        URL        => $FORM{url},
        USR_STATUS => $FORM{usr_status},
        NOTES      => $FORM{notes},
        LOCATION   => $FORM{location},
      }
    );
    $message = $html->message('info', "$lang{CHGED}", "$lang{CHG_MYSELF_INFO}");
  }


  my $user = $Users->list(
    { 
      ID => $UID, 
    }
  );
  $user = $user->[0];

  my $comments_count = $Tests->count_comments(
    { 
      USER  => $UID, 
    }
  );

  $comments_count = ($comments_count) ? $comments_count->[0]->{'COUNT(*)'} : 0;

  my $list_tests = $Tests->list_tests(
    { 
      UID  => $UID, 
      DESC => 'desc',
    }
  );

  my $test_box   = '';
  my $test_count = 0;
  my @range_color = ('success', 'warning', 'primary', 'danger', 'info', 'null');

  foreach my $test (@$list_tests){

    my $list_tests_tags = $Tests->list_tests_tags(
      { 
        COLS_NAME => 1, 
        PAGE_ROWS => 1,  
        TEST_ID   => $test->{id}, 
      }
    );
    my $tags      = '';
    my $tag_count = 0; 
    foreach my $tag (@$list_tests_tags){
      my $list_tags = $Tests->list_tags(
        {  
          ID => $tag->{tag_id}, 
        }
      );

      $tags .= "<span class='label label-$range_color[$tag_count]'><a href='/?tag=$tag->{tag_id}' style='color:white;'>$list_tags->[0]->{name}</a></span> ";
      $tag_count++;
    }

    $tags = ($tags) ? "<br>$tags": '';


    $test_count++;
    my $full_list_likes = $Tests->list_likes(
      {  
        COLS_NAME => 1, 
        PAGE_ROWS => 1,  
        TEST_ID   => $test->{id}, 
      }
    );

    my $rating = 0;
    foreach my $like (@$full_list_likes){
      if($like->{value} == 1){
        $rating++;
      }
      else{
        $rating--;
      }    
    }

    my $rating_color = 'primary';
    if($rating == 0){
      $rating_color = 'primary';
    }
    elsif($rating > 0){
      $rating_color = 'success';
    }
    else{
      $rating_color = 'danger';
    }

    $test->{url} = (length($test->{url})>5) ? "<img src='$test->{url}' class='img-thumbnail'>" : "<img src='https://ucarecdn.com/2c4f81e4-d18c-4aec-aa63-3994c554f1ea/' class='img-thumbnail'>";

    $test_box .= $html->tpl_show(templates('test_box'),
      {
        COL               => 6,
        TEST_NAME         => $test->{name},
        TEST_ID           => $test->{id},
        TEST_DESCRIPTION  => $test->{description},
        TEST_URL          => $test->{url},
        VIEWS             => $test->{viewing},
        RATING_COLOR      => $rating_color,
        RATING            => $rating,
        TAGS              => $tags,
      }
    );
  }

  my $list_likes = $Tests->list_likes(
    {  
      COLS_NAME => 1, 
      PAGE_ROWS => 1,  
      UID       => $UID, 
    }
  );

  my $like_test_box = '';

  foreach my $like (@$list_likes){
    my $like_list_tests = $Tests->list_tests(
      { 
        ID => $like->{test_id}, 
      }
    );
    $like_list_tests = $like_list_tests->[0];

    my $list_tests_tags = $Tests->list_tests_tags(
      { 
        COLS_NAME => 1, 
        PAGE_ROWS => 1,  
        TEST_ID   => $like_list_tests->{id}, 
      }
    );

    my $tags      = '';
    my $tag_count = 0; 
    foreach my $tag (@$list_tests_tags){
      my $list_tags = $Tests->list_tags(
        {  
          ID => $tag->{tag_id}, 
        }
      );

      $tags .= "<span class='label label-$range_color[$tag_count]'><a href='/?tag=$tag->{tag_id}' style='color:white;'>$list_tags->[0]->{name}</a></span> ";
      $tag_count++;
    }

    $tags = ($tags) ? "<br>$tags": '';

    my $full_list_likes = $Tests->list_likes(
      {  
        COLS_NAME => 1, 
        PAGE_ROWS => 1,  
        TEST_ID   => $like_list_tests->{id}, 
      }
    );

    my $rating = 0;
    foreach my $like (@$full_list_likes){
      if($like->{value} == 1){
        $rating++;
      }
      else{
        $rating--;
      }    
    }

    my $rating_color = 'primary';
    if($rating == 0){
      $rating_color = 'primary';
    }
    elsif($rating > 0){
      $rating_color = 'success';
    }
    else{
      $rating_color = 'danger';
    }

    $like_list_tests->{url} = (length($like_list_tests->{url})>5) ? "<img src='$like_list_tests->{url}' class='img-thumbnail'>" : "<img src='https://ucarecdn.com/2c4f81e4-d18c-4aec-aa63-3994c554f1ea/' class='img-thumbnail'>";

    $like_test_box .= $html->tpl_show(templates('test_box'),
      {
        COL               => 6,
        TEST_NAME         => $like_list_tests->{name},
        TEST_ID           => $like_list_tests->{id},
        TEST_DESCRIPTION  => $like_list_tests->{description},
        TEST_URL          => $like_list_tests->{url},
        VIEWS             => $like_list_tests->{viewing},
        RATING_COLOR      => $rating_color,
        RATING            => $rating,
        TAGS              => $tags,
      }
    );
  }

  my $user_url = (length($user->{url})>5) ? $user->{url}: 'http://citizen.edisha.gov.in/Content/assets/stylesheet/img/placeholder-user.png';
  print $html->tpl_show(templates('my_profile'),
    {
      LOGIN          => $user->{login},
      USERNAME       => $user->{username},
      URL            => $user->{url},
      USER_URL       => $user_url,
      LOCATION       => $user->{location},
      NOTES          => $user->{notes},
      USR_STATUS     => $user->{usr_status},
      TEST_BOX       => $test_box,
      LIKE_TEST_BOX  => $like_test_box,
      TEST_COUNT     => $test_count,
      COMMENTS_COUNT => $comments_count,
      MESSAGE        => $message,
    }
  );
}

#**********************************************************
=head2 USER PROFILE

=cut
#**********************************************************
elsif($FORM{user}){
  my $message = '';

  my $user = $Users->list(
    { 
      ID => $FORM{user}, 
    }
  );

  if(!$user){
    print $html->message('err', $lang{ERROR}, "$lang{ID_USER_EXIST}");
    exit;
  }

  $user = $user->[0];

  my $comments_count = $Tests->count_comments(
    { 
      USER  => $FORM{user}, 
    }
  );

  $comments_count = ($comments_count) ? $comments_count->[0]->{'COUNT(*)'} : 0;

  my $list_tests = $Tests->list_tests(
    { 
      UID  => $FORM{user}, 
      DESC => 'desc',
    }
  );

  my $test_box   = '';
  my $test_count = 0;
  my @range_color = ('success', 'warning', 'primary', 'danger', 'info', 'null');

  foreach my $test (@$list_tests){

    my $list_tests_tags = $Tests->list_tests_tags(
      { 
        COLS_NAME => 1, 
        PAGE_ROWS => 1,  
        TEST_ID   => $test->{id}, 
      }
    );
    my $tags      = '';
    my $tag_count = 0; 
    foreach my $tag (@$list_tests_tags){
      my $list_tags = $Tests->list_tags(
        {  
          ID => $tag->{tag_id}, 
        }
      );

      $tags .= "<span class='label label-$range_color[$tag_count]'><a href='/?tag=$tag->{tag_id}' style='color:white;'>$list_tags->[0]->{name}</a></span> ";
      $tag_count++;
    }

    $tags = ($tags) ? "<br>$tags": '';


    $test_count++;
    my $full_list_likes = $Tests->list_likes(
      {  
        COLS_NAME => 1, 
        PAGE_ROWS => 1,  
        TEST_ID   => $test->{id}, 
      }
    );

    my $rating = 0;
    foreach my $like (@$full_list_likes){
      if($like->{value} == 1){
        $rating++;
      }
      else{
        $rating--;
      }    
    }

    my $rating_color = 'primary';
    if($rating == 0){
      $rating_color = 'primary';
    }
    elsif($rating > 0){
      $rating_color = 'success';
    }
    else{
      $rating_color = 'danger';
    }

    $test->{url} = (length($test->{url})>5) ? "<img src='$test->{url}' class='img-thumbnail'>" : "<img src='https://ucarecdn.com/2c4f81e4-d18c-4aec-aa63-3994c554f1ea/' class='img-thumbnail'>";

    $test_box .= $html->tpl_show(templates('test_box'),
      {
        COL               => 6,
        TEST_NAME         => $test->{name},
        TEST_ID           => $test->{id},
        TEST_DESCRIPTION  => $test->{description},
        TEST_URL          => $test->{url},
        VIEWS             => $test->{viewing},
        RATING_COLOR      => $rating_color,
        RATING            => $rating,
        TAGS              => $tags,
      }
    );
  }

  my $list_likes = $Tests->list_likes(
    {  
      COLS_NAME => 1, 
      PAGE_ROWS => 1,  
      UID       => $FORM{user}, 
    }
  );

  my $like_test_box = '';

  foreach my $like (@$list_likes){
    my $like_list_tests = $Tests->list_tests(
      { 
        ID => $like->{test_id}, 
      }
    );
    $like_list_tests = $like_list_tests->[0];

    my $list_tests_tags = $Tests->list_tests_tags(
      { 
        COLS_NAME => 1, 
        PAGE_ROWS => 1,  
        TEST_ID   => $like_list_tests->{id}, 
      }
    );

    my $tags      = '';
    my $tag_count = 0; 
    foreach my $tag (@$list_tests_tags){
      my $list_tags = $Tests->list_tags(
        {  
          ID => $tag->{tag_id}, 
        }
      );

      $tags .= "<span class='label label-$range_color[$tag_count]'><a href='/?tag=$tag->{tag_id}' style='color:white;'>$list_tags->[0]->{name}</a></span> ";
      $tag_count++;
    }

    $tags = ($tags) ? "<br>$tags": '';

    my $full_list_likes = $Tests->list_likes(
      {  
        COLS_NAME => 1, 
        PAGE_ROWS => 1,  
        TEST_ID   => $like_list_tests->{id}, 
      }
    );

    my $rating = 0;
    foreach my $like (@$full_list_likes){
      if($like->{value} == 1){
        $rating++;
      }
      else{
        $rating--;
      }    
    }

    my $rating_color = 'primary';
    if($rating == 0){
      $rating_color = 'primary';
    }
    elsif($rating > 0){
      $rating_color = 'success';
    }
    else{
      $rating_color = 'danger';
    }

    $like_list_tests->{url} = (length($like_list_tests->{url})>5) ? "<img src='$like_list_tests->{url}' class='img-thumbnail'>" : "<img src='https://ucarecdn.com/2c4f81e4-d18c-4aec-aa63-3994c554f1ea/' class='img-thumbnail'>";

    $like_test_box .= $html->tpl_show(templates('test_box'),
      {
        COL               => 6,
        TEST_NAME         => $like_list_tests->{name},
        TEST_ID           => $like_list_tests->{id},
        TEST_DESCRIPTION  => $like_list_tests->{description},
        TEST_URL          => $like_list_tests->{url},
        VIEWS             => $like_list_tests->{viewing},
        RATING_COLOR      => $rating_color,
        RATING            => $rating,
        TAGS              => $tags,
      }
    );
  }

  my $user_url = (length($user->{url})>5) ? $user->{url}: 'http://citizen.edisha.gov.in/Content/assets/stylesheet/img/placeholder-user.png';
  print $html->tpl_show(templates('user'),
    {
      LOGIN          => $user->{login},
      USERNAME       => $user->{username},
      URL            => $user->{url},
      USER_URL       => $user_url,
      LOCATION       => $user->{location},
      NOTES          => $user->{notes},
      USR_STATUS     => $user->{usr_status},
      TEST_BOX       => $test_box,
      LIKE_TEST_BOX  => $like_test_box,
      TEST_COUNT     => $test_count,
      COMMENTS_COUNT => $comments_count,
      MESSAGE        => $message,
    }
  );
}

#**********************************************************
=head2 TESTS

=cut
#**********************************************************
elsif($FORM{tests}){

  my $date = $html->form_daterangepicker({ NAME => "DATE", FORM_NAME => "DATE"});
  my $test_box    = '';
  my $test_count  = 0;
  my @range_color = ('success', 'warning', 'primary', 'danger', 'info', 'null');
  my $sort        = ($FORM{select} &&  $FORM{select} == 2) ? 'viewing' : '';
  my $sort_selected = ($FORM{select} &&  $FORM{select} == 2) ? 'selected' : '';

  my $list_tests = $Tests->list_tests(
    { 
      SORT      => $sort,  
      DESC      => 'desc',
      DATE      => $FORM{DATE},
      PG        => 0,
      PAGE_ROWS => 25,
    }
  );

  foreach my $test (@$list_tests){

    my $list_tests_tags = $Tests->list_tests_tags(
      { 
        COLS_NAME => 1, 
        PAGE_ROWS => 1,
        TEST_ID   => $test->{id}, 
      }
    );
    my $tags      = '';
    my $tag_count = 0; 
    foreach my $tag (@$list_tests_tags){
      my $list_tags = $Tests->list_tags(
        {  
          ID => $tag->{tag_id}, 
        }
      );
      next if(!$list_tags);
      $tags .= "<span class='label label-$range_color[$tag_count]'><a href='/?tag=$tag->{tag_id}' style='color:white;'>$list_tags->[0]->{name}</a></span> ";
      $tag_count++;
    }

    $tags = ($tags) ? "<br>$tags": '';


    $test_count++;
    my $full_list_likes = $Tests->list_likes(
      {  
        COLS_NAME => 1, 
        PAGE_ROWS => 1,  
        TEST_ID   => $test->{id}, 
      }
    );

    my $rating = 0;
    foreach my $like (@$full_list_likes){
      if($like->{value} == 1){
        $rating++;
      }
      else{
        $rating--;
      }    
    }

    my $rating_color = 'primary';
    if($rating == 0){
      $rating_color = 'primary';
    }
    elsif($rating > 0){
      $rating_color = 'success';
    }
    else{
      $rating_color = 'danger';
    }

    $test->{url} = (length($test->{url})>5) ? "<img src='$test->{url}' class='img-thumbnail'>" : "<img src='https://ucarecdn.com/2c4f81e4-d18c-4aec-aa63-3994c554f1ea/' class='img-thumbnail'>";

    my $test_user = $Users->list(
      { 
        COLS_NAME => 1, 
        PAGE_ROWS => 1, 
        ID        => $test->{uid}, 
      }
    );
    my $test_user_icon = "<a href='/?user=$test_user->[0]->{id}'> \@$test_user->[0]->{login} </a>";

    $test_box .= $html->tpl_show(templates('test_box'),
      {
        COL               => 3,            
        TEST_NAME         => $test->{name},
        TEST_ID           => $test->{id},
        TEST_DESCRIPTION  => $test->{description},
        TEST_URL          => $test->{url},
        RATING_COLOR      => $rating_color,
        RATING            => $rating,
        VIEWS             => $test->{viewing},
        TAGS              => $tags,
        TEST_USER_ICON    => $test_user_icon,
      }
    );
  }

  print $html->tpl_show(templates('tests'),
    {
      DATE           => $date,
      TEST_BOX       => $test_box,
      SORT_SELECTED  => $sort_selected,
      HEADER         => "$lang{TESTS}",
      HEADER_SMALL   => "$lang{ALL_TESTS}",
      HIDDEN_NAME    => 'tests',
      HIDDEN_VALUE   => 'yes',
    }
  ); 
}


#**********************************************************
=head2 tags

=cut
#**********************************************************
elsif($FORM{tags}){

  # my $word   = encode_utf8('миска');
  # my ($letter) = $word =~ /(^.{3})/;
  my %tags_hash = ();
  # print  $letter;
  # print $letter;

  my $list_tags = $Tests->list_tags(
    { 
      SORT => 'name',  
    }
  );

  foreach my $tag (@$list_tags){
    my $count_tests_tags = $Tests->count_tests_tags(
      { 
        TAG_ID => $tag->{id},  
      }
    );
    my $letter= '';
    if($tag->{name} =~ /^[а-я]/){
      $letter = substr( $tag->{name}, 0, 2 );
    }
    else{
      $letter = substr( $tag->{name}, 0, 1 );
    }

    $tags_hash{$letter}->{$tag->{name}}->{count} = $count_tests_tags->[0]->{'COUNT(*)'};
    $tags_hash{$letter}->{$tag->{name}}->{id}    = $tag->{id};
  }

  
  my $tag_panel = '';
  foreach my $hash_letter (sort keys %tags_hash){
    my $tag_name = '';
    foreach my $hash_tag (keys %{$tags_hash{$hash_letter}}){
      $tag_name .= "<div class='col-md-2'><a href='/?tag=$tags_hash{$hash_letter}->{$hash_tag}->{id}' class='lead'>$hash_tag <small style='font-size: 70%'>$tags_hash{$hash_letter}->{$hash_tag}->{count}</small></a></div>";
    }
    $hash_letter =~ tr/a-z/A-Z/;
    $hash_letter =~ tr/йцукенгшщзхъфывапролджэячсмитьбюё/ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮЁ/;;
    $tag_panel .= $html->tpl_show(templates('tags_panel'),
      {
        TAG_NAME   => $tag_name,
        TAG_LATTER => $hash_letter,
      }
    );   
  } 

  print $html->tpl_show(templates('tags'),
    {
      TAGS_PANEL => $tag_panel,
    }
  );   
}

#**********************************************************
=head2 tag

=cut
#**********************************************************
elsif($FORM{tag}){

  my $date = $html->form_daterangepicker({ NAME => "DATE", FORM_NAME => "DATE"});
  my $test_box    = '';
  my $test_count  = 0;
  my @range_color = ('success', 'warning', 'primary', 'danger', 'info', 'null');
  my $sort        = ($FORM{select} &&  $FORM{select} == 2) ? 'viewing' : '';
  my $sort_selected = ($FORM{select} &&  $FORM{select} == 2) ? 'selected' : '';

  my $list_tests_tags = $Tests->list_tests_tags(
    { 
      TAG_ID => $FORM{tag},  
    }
  );

  if(!$list_tests_tags){
    print $html->message('err', $lang{ERROR}, "$lang{THIS_TAG_EXIST}");
    print $html->tpl_show(templates('footer'));
    exit;
  }

  foreach my $test_id (@$list_tests_tags){
    my $list_tests = $Tests->list_tests(
      { 
        SORT      => $sort,  
        DESC      => 'desc',
        DATE      => $FORM{DATE},
        PG        => 0,
        PAGE_ROWS => 25,
        ID        => $test_id->{test_id},
      }
    );
    foreach my $test (@$list_tests){

      my $list_tests_tags = $Tests->list_tests_tags(
        { 
          COLS_NAME => 1, 
          PAGE_ROWS => 1,
          TEST_ID   => $test->{id}, 
        }
      );
      my $tags      = '';
      my $tag_count = 0; 
      foreach my $tag (@$list_tests_tags){
        my $list_tags = $Tests->list_tags(
          {  
            ID => $tag->{tag_id}, 
          }
        );
        next if(!$list_tags);
        $tags .= "<span class='label label-$range_color[$tag_count]'><a href='/?tag=$tag->{tag_id}' style='color:white;'>$list_tags->[0]->{name}</a></span> ";
        $tag_count++;
      }

      $tags = ($tags) ? "<br>$tags": '';


      $test_count++;
      my $full_list_likes = $Tests->list_likes(
        {  
          COLS_NAME => 1, 
          PAGE_ROWS => 1,  
          TEST_ID   => $test->{id}, 
        }
      );

      my $rating = 0;
      foreach my $like (@$full_list_likes){
        if($like->{value} == 1){
          $rating++;
        }
        else{
          $rating--;
        }    
      }

      my $rating_color = 'primary';
      if($rating == 0){
        $rating_color = 'primary';
      }
      elsif($rating > 0){
        $rating_color = 'success';
      }
      else{
        $rating_color = 'danger';
      }

      $test->{url} = (length($test->{url})>5) ? "<img src='$test->{url}' class='img-thumbnail'>" : "<img src='https://ucarecdn.com/2c4f81e4-d18c-4aec-aa63-3994c554f1ea/' class='img-thumbnail'>";

      my $test_user = $Users->list(
        { 
          COLS_NAME => 1, 
          PAGE_ROWS => 1, 
          ID        => $test->{uid}, 
        }
      );
      my $test_user_icon = "<a href='/?user=$test_user->[0]->{id}'> \@$test_user->[0]->{login} </a>";

      $test_box .= $html->tpl_show(templates('test_box'),
        {
          COL               => 3,            
          TEST_NAME         => $test->{name},
          TEST_ID           => $test->{id},
          TEST_DESCRIPTION  => $test->{description},
          TEST_URL          => $test->{url},
          RATING_COLOR      => $rating_color,
          RATING            => $rating,
          VIEWS             => $test->{viewing},
          TAGS              => $tags,
          TEST_USER_ICON    => $test_user_icon,
        }
      );
    }
  }

  my $list_tags = $Tests->list_tags(
    { 
      ID => $FORM{tag},  
    }
  );

  print $html->tpl_show(templates('tests'),
    {
      DATE           => $date,
      TEST_BOX       => $test_box,
      SORT_SELECTED  => $sort_selected,
      HEADER         => "#$list_tags->[0]->{name}",
      HEADER_SMALL   => "$lang{SEARCH_BY_TAG}",
      HIDDEN_NAME    => 'tag',
      HIDDEN_VALUE   => $FORM{tag},
    }
  ); 
}

#**********************************************************
=head2 tag

=cut
#**********************************************************
elsif($FORM{q}){

  my $date = $html->form_daterangepicker({ NAME => "DATE", FORM_NAME => "DATE"});
  my $test_box      = '';
  my $test_count    = 0;
  my @range_color   = ('success', 'warning', 'primary', 'danger', 'info', 'null');
  my @user_color    = ('green', 'yellow', 'blue', 'red', 'aqua', 'null');
  my $sort_selected = ($FORM{select} &&  $FORM{select} == 2) ? 'selected' : '';

  if($FORM{select} && $FORM{select} == 2){
    my $search = $FORM{q}; $search =~ s/@//;

    my $search_list = $Users->search_list(
      {   
        DESC      => 'desc',
        PG        => 0,
        PAGE_ROWS => 25,
        SEARCH    => $search,
      }
    );

    my $user_count = 0;
    foreach my $user (@$search_list){
      my $comments_count = $Tests->count_comments(
        { 
          USER  => $user->{id}, 
        }
      );

      my $count_tests = $Tests->count_tests(
        { 
          UID  => $user->{id}, 
        }
      );

      $count_tests    = ($count_tests)    ? $count_tests->[0]->{'COUNT(*)'} : 0;
      $comments_count = ($comments_count) ? $comments_count->[0]->{'COUNT(*)'} : 0;

      my $user_url = (length($user->{url})>5) ? $user->{url} : 'http://citizen.edisha.gov.in/Content/assets/stylesheet/img/placeholder-user.png';

      $test_box .= $html->tpl_show(templates('user_box'),
        {
          COL            => 3,            
          USERNAME       => $user->{username},
          USR_STATUS     => $user->{usr_status},
          LOGIN          => $user->{login},
          ID             => $user->{id},
          URL            => $user_url,
          COMMENTS_COUNT => $comments_count,
          COUNT_TESTS    => $count_tests,
          COLOR          => $user_color[$user_count],
        }
      );
      if($user_count >= 5){
        $user_count = 0;
      }
      $user_count++;
    }

  }
  else{
    my $search_list_tests = $Tests->search_list_tests(
      { 
        SORT      => 'viewing',  
        DESC      => 'desc',
        DATE      => $FORM{DATE},
        PG        => 0,
        PAGE_ROWS => 25,
        SEARCH    => $FORM{q},
      }
    );

    # _bp('', $search_list_tests);
    foreach my $test (@$search_list_tests){

      my $list_tests_tags = $Tests->list_tests_tags(
        { 
          COLS_NAME => 1, 
          PAGE_ROWS => 1,
          TEST_ID   => $test->{id}, 
        }
      );
      my $tags      = '';
      my $tag_count = 0; 
      foreach my $tag (@$list_tests_tags){
        my $list_tags = $Tests->list_tags(
          {  
            ID => $tag->{tag_id}, 
          }
        );
        next if(!$list_tags);
        $tags .= "<span class='label label-$range_color[$tag_count]'><a href='/?tag=$tag->{tag_id}' style='color:white;'>$list_tags->[0]->{name}</a></span> ";
        $tag_count++;
      }

      $tags = ($tags) ? "<br>$tags": '';


      $test_count++;
      my $full_list_likes = $Tests->list_likes(
        {  
          COLS_NAME => 1, 
          PAGE_ROWS => 1,  
          TEST_ID   => $test->{id}, 
        }
      );

      my $rating = 0;
      foreach my $like (@$full_list_likes){
        if($like->{value} == 1){
          $rating++;
        }
        else{
          $rating--;
        }    
      }

      my $rating_color = 'primary';
      if($rating == 0){
        $rating_color = 'primary';
      }
      elsif($rating > 0){
        $rating_color = 'success';
      }
      else{
        $rating_color = 'danger';
      }

      $test->{url} = (length($test->{url})>5) ? "<img src='$test->{url}' class='img-thumbnail'>" : "<img src='https://ucarecdn.com/2c4f81e4-d18c-4aec-aa63-3994c554f1ea/' class='img-thumbnail'>";

      my $test_user = $Users->list(
        { 
          COLS_NAME => 1, 
          PAGE_ROWS => 1, 
          ID        => $test->{uid}, 
        }
      );
      my $test_user_icon = "<a href='/?user=$test_user->[0]->{id}'> \@$test_user->[0]->{login} </a>";

      $test_box .= $html->tpl_show(templates('test_box'),
        {
          COL               => 3,            
          TEST_NAME         => $test->{name},
          TEST_ID           => $test->{id},
          TEST_DESCRIPTION  => $test->{description},
          TEST_URL          => $test->{url},
          RATING_COLOR      => $rating_color,
          RATING            => $rating,
          VIEWS             => $test->{viewing},
          TAGS              => $tags,
          TEST_USER_ICON    => $test_user_icon,
        }
      );
    }
  }

  print $html->tpl_show(templates('search_tests'),
    {
      DATE           => $date,
      TEST_BOX       => $test_box,
      SORT_SELECTED  => $sort_selected,
      HEADER         => "$lang{SEARCH}",
      HEADER_SMALL   => "$lang{SEARCH_IN_SITE}",
      SEARCH         => $FORM{q},
    }
  ); 

  
}

elsif($FORM{MD}){
  my $the_message = "http://192.168.1.103/?MD=2";
  my $the_key = "bbc21249";

  my $test_encode = &string2hex(&RC4($the_message,$the_key));
  my $test_decode = &RC4(&hex2string($test_encode),$the_key);

  print $test_encode . "\n\n" . $test_decode;

  sub RC4 {
   my($message,$key) = @_;
   my($RC4);
   my(@asciiary);
   my(@keyary);
   my($index,$jump,$temp,$y,$t,$x,$keylen);
   $keylen = length($key);
   for ($index = 0; $index <= 255; $index++) {
    $keyary[$index] = ord(substr($key, ($index%$keylen) + 1, 1));
   }
   for ($index = 0; $index <= 255; $index++) {$asciiary[$index] = $index;}
   $jump = 0;
   for ($index = 0; $index <= 255; $index++) {
    $jump = ($jump + $asciiary[$index] + $keyary[$index])%256;
    $temp = $asciiary[$index];
    $asciiary[$index] = $asciiary[$jump];
    $asciiary[$jump] = $temp;
   }
   $index = 0;
   $jump = 0;
   for ($x = 0; $x < length($message); $x++) {
    $index = ($index + 1)%256;
    $jump = ($jump + $asciiary[$index])%256;
    $t = ($asciiary[$index] + $asciiary[$jump])%256;
    $temp = $asciiary[$index];
    $asciiary[$index] = $asciiary[$jump];
    $asciiary[$jump] = $temp;
    $y = $asciiary[$t];
    $RC4 .= chr(ord(substr($message, $x, 1))^$y);
   }
   return($RC4);
  }

  sub string2hex {
   my($instring) = @_;
   my($retval,$strlen,$posx,$tval,$h1,$h2);
   my(@hexvals) = ('0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F');
   $strlen = length($instring);
   for ($posx = 0; $posx < $strlen; $posx++) {
    $tval = ord(substr($instring,$posx,1));
    $h1 = int($tval/16);
    $h2 = int($tval - ($h1*16));
    $retval .= $hexvals[$h1] . $hexvals[$h2];
   }
   return($retval);
  }

  sub hex2string {
   my($instring) = @_;
   my($retval,$strlen,$posx);
   $strlen = length($instring);
   for ($posx = 0; $posx < $strlen; $posx=$posx+2) {
    $retval .= chr(hex(substr($instring,$posx,2)));
   }
   return($retval);
  }
}

elsif(!$FORM{FAQ} && !$FORM{test}){
  my $count_tests = $Tests->count_tests(
    { 
      COLS_NAME => 1, 
      PAGE_ROWS => 1, 
    }
  );
  my $count_users = $Users->count_users();
  my $count_tags  = $Tests->count_tags();

  print $html->tpl_show(templates('main_page'),
    {
      COUNT_TESTS => $count_tests->[0]->{'COUNT(*)'},
      COUNT_USERS => $count_users->[0]->{'COUNT(*)'},
      COUNT_TAGS => $count_tags->[0]->{'COUNT(*)'},
    }
  );
}

print $html->tpl_show(templates('footer'));





# print $UID;

# printf("%04d-%02d-%02d",  (1900+$year), (1+$mon), $mday);

