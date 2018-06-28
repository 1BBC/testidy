package Users;

=head2

  Users

=cut

use strict;
use parent 'main';
my $MODULE = 'Users';

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

=head2  add()

=cut

#**********************************************************
sub add {
  my $self = shift;
  my ($attr) = @_;

  $self->query_add('users', $attr);

  return $self;
}

#**********************************************************

=head2  add_element()

=cut

#**********************************************************
sub add_element {
  my $self = shift;
  my ($attr) = @_;

  $self->query_add('Users_element', $attr);

  return $self;
}

#**********************************************************

=head2  del() - Delete user info from all tables

=cut

#**********************************************************
sub del {
  my $self = shift;
  my ($attr) = @_;

  $self->query_del('Users', undef, $attr);

  return $self->{result};
}

#**********************************************************

=head2  del_element() - Delete element

=cut

#**********************************************************
sub del_element {
  my $self = shift;
  my ($id) = @_;

  $self->query_del('Users_element', { ID => $id });

  return $self->{result};
}

#**********************************************************

=head2 list($attr) - list for element

=cut

#**********************************************************
sub list {
  my $self = shift;
  my ($attr) = @_;

  my $SORT = ($attr->{SORT}) ? $attr->{SORT} : 1;
  my $DESC = ($attr->{DESC}) ? $attr->{DESC} : '';

  #my $PG        = ($attr->{PG})        ? $attr->{PG}             : 0;
  #my $PAGE_ROWS = ($attr->{PAGE_ROWS}) ? int($attr->{PAGE_ROWS}) : 25;

  my $WHERE = $self->search_former( $attr, [
      [ 'ID',         'INT', 'id',          1],
      [ 'LOGIN',      'STR', 'login',       1],
      [ 'PASSWORD',   'STR', 'password',    1],
      [ 'EMAIL',      'STR', 'email',       1],
      [ 'USERNAME',   'STR', 'username',    1],
      [ 'URL',        'STR', 'url',         1],
      [ 'location',   'STR', 'location',    1],
      [ 'notes',      'STR', 'notes',       1],
      [ 'usr_status', 'STR', 'usr_status',  1],
    ],
    { WHERE => 1,
    }
  );

  $self->query2(
    "SELECT *
     FROM users $WHERE;",
    undef,
    { COLS_NAME => 1 }
  );

  return $self->{list};
}

#**********************************************************
=head2 count_users($attr) - count_users

=cut
#**********************************************************
sub count_users {
  my $self = shift;
  my ($attr) = @_;

  $self->query2(
    "SELECT COUNT(*)
     FROM users;",
    undef,
    { COLS_NAME => 1 }
  );

  return $self->{list};
}
#**********************************************************

=head2 search_list($attr) - list for element

=cut

#**********************************************************
sub search_list {
  my $self = shift;
  my ($attr) = @_;

  my $SORT = ($attr->{SORT}) ? $attr->{SORT} : 1;
  my $DESC = ($attr->{DESC}) ? $attr->{DESC} : '';

  my $PG        = ($attr->{PG})        ? $attr->{PG}             : 0;
  my $PAGE_ROWS = (length($attr->{PAGE_ROWS})>=1) ? int($attr->{PAGE_ROWS}) : 25;

  $self->query2(
    "SELECT * FROM users WHERE username LIKE '%$attr->{SEARCH}%' OR login LIKE '%$attr->{SEARCH}%' ORDER BY $SORT $DESC LIMIT $PG, $PAGE_ROWS;",
    undef,
    { COLS_NAME => 1 }
  );

  return $self->{list};
}


#**********************************************************
=head2 change_user_info($attr) -  change_user_info

=cut
#**********************************************************
sub change_user_info {
  my $self = shift;
  my ($attr) = @_;

  $self->query2("UPDATE users SET username='$attr->{USERNAME}', usr_status='$attr->{USR_STATUS}', url='$attr->{URL}', notes='$attr->{NOTES}', location='$attr->{LOCATION}' WHERE id=$attr->{ID};", 'do', { Bind => [ 0 ] });

  return $self->{result};
}
