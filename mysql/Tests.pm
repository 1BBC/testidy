package Tests;

=head2

  Tests

=cut

use strict;
use parent 'main';
my $MODULE = 'Tests';

#**********************************************************
# Init
#**********************************************************
sub new {
  my $class = shift;
  my ($db, $CONF) = @_;

  my $self = {};
  bless($self, $class);

  $self->{db}      = $db;
  $self->{conf}    = $CONF;

  return $self;
}

#**********************************************************
=head2 list_tests($attr) - list for tests

=cut
#**********************************************************
sub list_tests {
  my $self = shift;
  my ($attr) = @_;

  my $SORT = ($attr->{SORT}) ? $attr->{SORT} : 1;
  my $DESC = ($attr->{DESC}) ? $attr->{DESC} : '';
  my $PG        = ($attr->{PG})        ? $attr->{PG}        : 0;
  my $PAGE_ROWS = (length($attr->{PAGE_ROWS})>1) ? $attr->{PAGE_ROWS} : 25;

  my $WHERE = $self->search_former( $attr, [
      [ 'ID',          'INT', 'id',          1],
      [ 'DATE',        'DATE','date',        1],
      [ 'NAME',        'STR', 'name',        1],
      [ 'URL',         'STR', 'url',         1],
      [ 'UID',         'INT', 'uid',         1],
      [ 'RATING',      'INT', 'rating',      1],
      [ 'VIEWING',     'STR', 'viewing',     1],
      [ 'DESCRIPTION', 'STR', 'description', 1],
    ],
    { WHERE => 1,
    }
  );

  $self->query2(
    "SELECT *
     FROM tests $WHERE ORDER BY $SORT $DESC LIMIT $PG, $PAGE_ROWS;",
    undef,
    { COLS_NAME => 1 }
  );

  return $self->{list};
}

#**********************************************************
=head2 search_list_tests($attr) - list for tests

=cut
#**********************************************************
sub search_list_tests {
  my $self = shift;
  my ($attr) = @_;

  my $SORT = ($attr->{SORT}) ? $attr->{SORT} : 1;
  my $DESC = ($attr->{DESC}) ? $attr->{DESC} : '';
  my $PG        = ($attr->{PG})        ? $attr->{PG}        : 0;
  my $PAGE_ROWS = (length($attr->{PAGE_ROWS})>1) ? $attr->{PAGE_ROWS} : 25;

  $self->query2(
    "SELECT * FROM tests WHERE name LIKE '%$attr->{SEARCH}%' OR description LIKE '%$attr->{SEARCH}%'ORDER BY $SORT $DESC LIMIT $PG, $PAGE_ROWS;",
    undef,
    { COLS_NAME => 1 }
  );

  return $self->{list};
}
#**********************************************************
=head2 list_tests_result($attr) - list tests result

=cut
#**********************************************************
sub list_tests_result {
  my $self = shift;
  my ($attr) = @_;

  my $SORT = ($attr->{SORT}) ? $attr->{SORT} : 1;
  my $DESC = ($attr->{DESC}) ? $attr->{DESC} : '';
  # my $PG        = ($attr->{PG})        ? $attr->{PG}        : 0;
  # my $PAGE_ROWS = ($attr->{PAGE_ROWS}) ? $attr->{PAGE_ROWS} : 25;

  my $WHERE = $self->search_former( $attr, [
      [ 'ID',          'INT', 'id',          1],
      [ 'TEST_ID',     'INT', 'test_id',     1],
      [ 'NAME',        'STR', 'name',        1],
      [ 'DESCRIPTION', 'STR', 'description', 1],
      [ 'URL',         'STR', 'url',         1],
    ],
    { WHERE => 1,
    }
  );

  $self->query2(
    "SELECT *
     FROM tests_result $WHERE",
    undef,
    { COLS_NAME => 1 }
  );

  return $self->{list};
}

#**********************************************************
=head2 list_comments($attr) - list_comments

=cut
#**********************************************************
sub list_comments {
  my $self = shift;
  my ($attr) = @_;

  my $SORT = ($attr->{SORT}) ? $attr->{SORT} : 1;
  my $DESC = ($attr->{DESC}) ? $attr->{DESC} : '';
  # my $PG        = ($attr->{PG})        ? $attr->{PG}        : 0;
  # my $PAGE_ROWS = ($attr->{PAGE_ROWS}) ? $attr->{PAGE_ROWS} : 25;

  my $WHERE = $self->search_former( $attr, [
      [ 'ID',       'INT', 'id',          1],
      [ 'TEST_ID',  'INT', 'test_id',     1],
      [ 'UID',      'INT', 'uid',         1],
      [ 'USER',     'INT', 'user',        1],
      [ 'COMMENT',  'STR', 'comment',     1],
      [ 'VIEWED',   'INT', 'viewed',      1],
    ],
    { WHERE => 1,
    }
  );

  $self->query2(
    "SELECT *
     FROM comments $WHERE",
    undef,
    { COLS_NAME => 1 }
  );

  return $self->{list};
}

#**********************************************************
=head2 list_tags($attr) - list_tags

=cut
#**********************************************************
sub list_tags {
  my $self = shift;
  my ($attr) = @_;

  my $SORT = ($attr->{SORT}) ? $attr->{SORT} : 1;
  my $DESC = ($attr->{DESC}) ? $attr->{DESC} : '';

  my $WHERE = $self->search_former( $attr, [
      [ 'ID',          'INT', 'id',          1],
      [ 'NAME',        'STR', 'name',        1],
    ],
    { WHERE => 1,
    }
  );

  $self->query2(
    "SELECT *
     FROM tags $WHERE ORDER BY $SORT $DESC;",
    undef,
    { COLS_NAME => 1 }
  );

  return $self->{list};
}


#**********************************************************
=head2 count_tags($attr) - count_tags

=cut
#**********************************************************
sub count_tags {
  my $self = shift;
  my ($attr) = @_;

  $self->query2(
    "SELECT COUNT(*)
     FROM tags;",
    undef,
    { COLS_NAME => 1 }
  );

  return $self->{list};
}

#**********************************************************
=head2 list_tests_tags($attr) - tests_tags

=cut
#**********************************************************
sub list_tests_tags {
  my $self = shift;
  my ($attr) = @_;

  my $SORT = ($attr->{SORT}) ? $attr->{SORT} : 1;
  my $DESC = ($attr->{DESC}) ? $attr->{DESC} : '';

  my $WHERE = $self->search_former( $attr, [
      [ 'ID',          'INT', 'id',      1],
      [ 'TEST_ID',     'STR', 'test_id', 1],
      [ 'TAG_ID',      'INT', 'tag_id',  1],
    ],
    { WHERE => 1,
    }
  );

  $self->query2(
    "SELECT *
     FROM tests_tags $WHERE;",
    undef,
    { COLS_NAME => 1 }
  );

  return $self->{list};
}

#**********************************************************
=head2 list_tests_questions($attr) - list tests result

=cut
#**********************************************************
sub list_tests_questions {
  my $self = shift;
  my ($attr) = @_;

  my $SORT = ($attr->{SORT}) ? $attr->{SORT} : 1;
  my $DESC = ($attr->{DESC}) ? $attr->{DESC} : '';

  my $WHERE = $self->search_former( $attr, [
      [ 'ID',          'INT', 'id',          1],
      [ 'TEST_ID',     'INT', 'test_id',     1],
      [ 'NAME',        'STR', 'name',        1],
      [ 'DESCRIPTION', 'STR', 'description', 1],
      [ 'URL',         'STR', 'url',         1],
    ],
    { WHERE => 1,
    }
  );

  $self->query2(
    "SELECT *
     FROM tests_questions $WHERE;",
    undef,
    { COLS_NAME => 1 }
  );

  return $self->{list};
}

#**********************************************************
=head2 count_tests_questions($attr) - list tests result

=cut
#**********************************************************
sub count_tests_questions {
  my $self = shift;
  my ($attr) = @_;

  my $SORT = ($attr->{SORT}) ? $attr->{SORT} : 1;
  my $DESC = ($attr->{DESC}) ? $attr->{DESC} : '';

  my $WHERE = $self->search_former( $attr, [
      [ 'TEST_ID', 'INT', 'test_id', 1],
    ],
    { WHERE => 1,
    }
  );

  $self->query2(
    "SELECT COUNT(*)
     FROM tests_questions $WHERE;",
    undef,
    { COLS_NAME => 1 }
  );

  return $self->{list};
}

#**********************************************************
=head2 list_tests_answers($attr) - list tests answers

=cut
#**********************************************************
sub list_tests_answers {
  my $self = shift;
  my ($attr) = @_;

  my $SORT = ($attr->{SORT}) ? $attr->{SORT} : 1;
  my $DESC = ($attr->{DESC}) ? $attr->{DESC} : '';

  my $WHERE = $self->search_former( $attr, [
      [ 'ID',          'INT', 'id',          1],
      [ 'TEST_ID',     'INT', 'test_id',     1],
      [ 'QUESTION_ID', 'INT', 'question_id', 1],
      [ 'NAME',        'STR', 'name',        1],
    ],
    { WHERE => 1,
    }
  );

  $self->query2(
    "SELECT *
     FROM tests_answers $WHERE;",
    undef,
    { COLS_NAME => 1 }
  );

  return $self->{list};
}

#**********************************************************
=head2 list_tests_answers_value($attr) - list tests answers value

=cut
#**********************************************************
sub list_tests_answers_value {
  my $self = shift;
  my ($attr) = @_;

  my $SORT = ($attr->{SORT}) ? $attr->{SORT} : 1;
  my $DESC = ($attr->{DESC}) ? $attr->{DESC} : '';

  my $WHERE = $self->search_former( $attr, [
      [ 'ID',          'INT', 'id',          1],
      [ 'TEST_ID',     'INT', 'test_id',     1],
      [ 'RESULT_ID',   'INT', 'result_id',   1],   
      [ 'ANSWERS_ID',  'INT', 'answers_id',  1],
      [ 'VALUE',       'INT', 'value',       1],
    ],
    { WHERE => 1,
    }
  );

  $self->query2(
    "SELECT *
     FROM tests_answers_value $WHERE;",
    undef,
    { COLS_NAME => 1 }
  );

  return $self->{list};
}

#**********************************************************
=head2 list_likes($attr) - list_likes

=cut
#**********************************************************
sub list_likes {
  my $self = shift;
  my ($attr) = @_;

  my $SORT = ($attr->{SORT}) ? $attr->{SORT} : 1;
  my $DESC = ($attr->{DESC}) ? $attr->{DESC} : '';

  my $WHERE = $self->search_former( $attr, [
      [ 'ID',        'INT', 'id',          1],
      [ 'UID',       'INT', 'uid',         1],
      [ 'TEST_ID',   'INT', 'test_id',     1],   
      [ 'VALUE',     'INT', 'value',       1],
    ],
    { WHERE => 1,
    }
  );

  $self->query2(
    "SELECT *
     FROM likes $WHERE;",
    undef,
    { COLS_NAME => 1 }
  );

  return $self->{list};
}

#**********************************************************
=head2 count_tests_answers($attr) - count tests answers

=cut
#**********************************************************
sub count_tests_answers {
  my $self = shift;
  my ($attr) = @_;

  my $SORT = ($attr->{SORT}) ? $attr->{SORT} : 1;
  my $DESC = ($attr->{DESC}) ? $attr->{DESC} : '';

  my $WHERE = $self->search_former( $attr, [
      [ 'TEST_ID',     'INT', 'test_id', 1],
      [ 'QUESTION_ID', 'INT', 'question_id', 1],
      
    ],
    { WHERE => 1,
    }
  );

  $self->query2(
    "SELECT COUNT(*)
     FROM tests_answers $WHERE;",
    undef,
    { COLS_NAME => 1 }
  );

  return $self->{list};
}

#**********************************************************
=head2 count_tests_result($attr) - count tests result

=cut
#**********************************************************
sub count_tests_result {
  my $self = shift;
  my ($attr) = @_;

  my $SORT = ($attr->{SORT}) ? $attr->{SORT} : 1;
  my $DESC = ($attr->{DESC}) ? $attr->{DESC} : '';

  my $WHERE = $self->search_former( $attr, [
      [ 'TEST_ID', 'INT', 'test_id', 1],
    ],
    { WHERE => 1,
    }
  );

  $self->query2(
    "SELECT COUNT(*)
     FROM tests_result $WHERE;",
    undef,
    { COLS_NAME => 1 }
  );

  return $self->{list};
}


#**********************************************************
=head2 count_tests($attr) - count_tests

=cut
#**********************************************************
sub count_tests {
  my $self = shift;
  my ($attr) = @_;

  my $SORT = ($attr->{SORT}) ? $attr->{SORT} : 1;
  my $DESC = ($attr->{DESC}) ? $attr->{DESC} : '';

  my $WHERE = $self->search_former( $attr, [
      [ 'UID', 'INT', 'uid', 1],
    ],
    { WHERE => 1,
    }
  );

  $self->query2(
    "SELECT COUNT(*)
     FROM tests $WHERE;",
    undef,
    { COLS_NAME => 1 }
  );

  return $self->{list};
}
#**********************************************************
=head2 count_tests_tags($attr) - count_tests_tags

=cut
#**********************************************************
sub count_tests_tags {
  my $self = shift;
  my ($attr) = @_;

  my $SORT = ($attr->{SORT}) ? $attr->{SORT} : 1;
  my $DESC = ($attr->{DESC}) ? $attr->{DESC} : '';

  my $WHERE = $self->search_former( $attr, [
      [ 'TEST_ID', 'INT', 'test_id', 1],
      [ 'TAG_ID',  'INT', 'tag_id',  1],
    ],
    { WHERE => 1,
    }
  );

  $self->query2(
    "SELECT COUNT(*)
     FROM tests_tags $WHERE;",
    undef,
    { COLS_NAME => 1 }
  );

  return $self->{list};
}

#**********************************************************
=head2 count_comments($attr)

=cut
#**********************************************************
sub count_comments {
  my $self = shift;
  my ($attr) = @_;

  my $SORT = ($attr->{SORT}) ? $attr->{SORT} : 1;
  my $DESC = ($attr->{DESC}) ? $attr->{DESC} : '';

  my $WHERE = $self->search_former( $attr, [
      [ 'USER', 'INT', 'user', 1],
    ],
    { WHERE => 1,
    }
  );

  $self->query2(
    "SELECT COUNT(*)
     FROM comments $WHERE;",
    undef,
    { COLS_NAME => 1 }
  );

  return $self->{list};
}

#**********************************************************
=head2 change_tests($attr) -  Change element

=cut
#**********************************************************
sub change_tests {
  my $self = shift;
  my ($attr) = @_;

  $self->query2("UPDATE tests SET name='$attr->{NAME}', description='$attr->{DESCRIPTION}', url='$attr->{URL}' WHERE id=$attr->{ID};", 'do', { Bind => [ 0 ] });

  return $self->{result};
}

#**********************************************************
=head2 update_tests_viewing($attr) -  Change element

=cut
#**********************************************************
sub update_tests_viewing {
  my $self = shift;
  my ($attr) = @_;

  $self->query2("UPDATE tests SET viewing='$attr->{VIEWING}' WHERE id=$attr->{ID};", 'do', { Bind => [ 0 ] });

  return $self->{result};
}

#**********************************************************
=head2 change_tests_result($attr) -  Change tests result

=cut
#**********************************************************
sub change_tests_result {
  my $self = shift;
  my ($attr) = @_;

  $self->query2("UPDATE tests_result SET name='$attr->{NAME}', description='$attr->{DESCRIPTION}', url='$attr->{URL}' WHERE id=$attr->{ID};", 'do', { Bind => [ 0 ] });

  return $self->{result};
}

#**********************************************************
=head2 change_tests_questions($attr) -  Change tests result

=cut
#**********************************************************
sub change_tests_questions {
  my $self = shift;
  my ($attr) = @_;

  $self->query2("UPDATE tests_questions SET name='$attr->{NAME}', description='$attr->{DESCRIPTION}', url='$attr->{URL}' WHERE id=$attr->{ID};", 'do', { Bind => [ 0 ] });

  return $self->{result};
}

#**********************************************************
=head2  add_tests()

=cut
#**********************************************************
sub add_tests {
  my $self = shift;
  my ($attr) = @_;

  $self->query_add('tests', $attr);

  return $self;
}

#**********************************************************
=head2  add_like()

=cut
#**********************************************************
sub add_like {
  my $self = shift;
  my ($attr) = @_;

  $self->query_add('likes', $attr);

  return $self;
}

#**********************************************************
=head2  add_comment()

=cut
#**********************************************************
sub add_comment {
  my $self = shift;
  my ($attr) = @_;

  $self->query_add('comments', $attr);

  return $self;
}

#**********************************************************
=head2  add_report()

=cut
#**********************************************************
sub add_report {
  my $self = shift;
  my ($attr) = @_;

  $self->query_add('reports', $attr);

  return $self;
}

#**********************************************************
=head2  add_tests_result()

=cut
#**********************************************************
sub add_tests_result {
  my $self = shift;
  my ($attr) = @_;

  $self->query_add('tests_result', $attr);

  return $self;
}

#**********************************************************
=head2  add_tests_tags()

=cut
#**********************************************************
sub add_tests_tags {
  my $self = shift;
  my ($attr) = @_;

  $self->query_add('tests_tags', $attr);

  return $self;
}

#**********************************************************
=head2  add_tests_result()

=cut
#**********************************************************
sub add_tags {
  my $self = shift;
  my ($attr) = @_;

  $self->query_add('tags', $attr);

  return $self;
}

#**********************************************************
=head2  del_tests_result()

=cut
#**********************************************************
sub del_tests_result {
  my $self = shift;
  my ($id) = @_;

  $self->query_del('tests_result', { ID => $id });

  return $self->{result};
}

#**********************************************************
=head2  add_tests_questions()

=cut
#**********************************************************
sub add_tests_questions {
  my $self = shift;
  my ($attr) = @_;

  $self->query_add('tests_questions', $attr);

  return $self;
}

#**********************************************************
=head2  add_tests_answers()

=cut
#**********************************************************
sub add_tests_answers {
  my $self = shift;
  my ($attr) = @_;

  $self->query_add('tests_answers', $attr);

  return $self;
}

#**********************************************************
=head2  add_tests_answers_value()

=cut
#**********************************************************
sub add_tests_answers_value {
  my $self = shift;
  my ($attr) = @_;

  $self->query_add('tests_answers_value', $attr);

  return $self;
}

#**********************************************************
=head2  del_tests_questions()

=cut
#**********************************************************
sub del_tests_questions {
  my $self = shift;
  my ($id) = @_;

  $self->query_del('tests_questions', { ID => $id });
  $self->query2("DELETE FROM tests_answers WHERE question_id=$id;",       'do', { Bind => [ 0 ] });
  $self->query2("DELETE FROM tests_answers_value WHERE question_id=$id;", 'do', { Bind => [ 0 ] });

  return $self->{result};
}

#**********************************************************
=head2  del_tests()

=cut
#**********************************************************
sub del_tests {
  my $self = shift;
  my ($id) = @_;

  $self->query_del('tests', { ID => $id });
  $self->query2("DELETE FROM tests_result WHERE test_id=$id;",        'do', { Bind => [ 0 ] });
  $self->query2("DELETE FROM tests_questions WHERE test_id=$id;",     'do', { Bind => [ 0 ] });
  $self->query2("DELETE FROM tests_answers WHERE test_id=$id;",       'do', { Bind => [ 0 ] });
  $self->query2("DELETE FROM tests_answers_value WHERE test_id=$id;", 'do', { Bind => [ 0 ] });
  $self->query2("DELETE FROM tests_tags WHERE test_id=$id;",          'do', { Bind => [ 0 ] });


  return $self->{result};
}

#**********************************************************
=head2  del_like()

=cut
#**********************************************************
sub del_like {
  my $self = shift;
  my ($attr) = @_;

  $self->query2("DELETE FROM likes WHERE test_id=$attr->{TEST_ID} AND uid=$attr->{UID};",        'do', { Bind => [ 0 ] });

  return $self->{result};
}

#**********************************************************
=head2  del_comment()

=cut
#**********************************************************
sub del_comment {
  my $self = shift;
  my ($attr) = @_;

  $self->query2("DELETE FROM comments WHERE test_id=$attr->{TEST_ID} AND uid=$attr->{UID} AND comment='$attr->{COMMENT}';",        'do', { Bind => [ 0 ] });

  return $self->{result};
}

#**********************************************************
=head2  del_comment_id()

=cut
#**********************************************************
sub del_comment_id {
  my $self = shift;
  my ($attr) = @_;

  $self->query2("DELETE FROM comments WHERE test_id=$attr->{TEST_ID} AND uid=$attr->{UID} AND id=$attr->{ID};",        'do', { Bind => [ 0 ] });

  return $self->{result};
}


#**********************************************************
=head2  del_report()

=cut
#**********************************************************
sub del_report{
  my $self = shift;
  my ($attr) = @_;

  $self->query2("DELETE FROM reports WHERE test_id=$attr->{TEST_ID} AND uid=$attr->{UID};",        'do', { Bind => [ 0 ] });

  return $self->{result};
}

#**********************************************************
=head2  del_tests_tags()

=cut
#**********************************************************
sub del_tests_tags {
  my $self = shift;
  my ($id) = @_;

  $self->query2("DELETE FROM tests_tags WHERE test_id=$id;", 'do', { Bind => [ 0 ] });

  return $self->{result};
}

#**********************************************************
=head2  del_tests_answers()

=cut
#**********************************************************
sub del_tests_answers {
  my $self = shift;
  my ($id) = @_;

  $self->query2("DELETE FROM tests_answers WHERE question_id=$id;", 'do', { Bind => [ 0 ] });
  $self->query2("DELETE FROM tests_answers_value WHERE question_id=$id;", 'do', { Bind => [ 0 ] });

  return $self->{result};
}

#**********************************************************
=head2 update_views($attr) -  Change element

=cut
#**********************************************************
sub update_views {
  my $self = shift;
  my ($attr) = @_;
  $attr->{VIEWED} = 1;

  $self->query2("UPDATE comments SET viewed='$attr->{VIEWED}' WHERE user='$attr->{USER}';", 'do', { Bind => [ 0 ] });

  return $self->{result};
}