=head1 NAME

  Templates Managments

=cut

use strict;

my $domain_path = '';
our (
  $Bin,
  %FORM,
  $admin,
  $html,
  %lang,
  %conf
);

use FindBin '$Bin';

#**********************************************************
=head2 tpl_content($filename, $attr)

=cut
#**********************************************************
sub tpl_content {
  my ($filename) = @_;
  my $tpl_content = '';

  open(my $fh, '<', $filename) || die "Can't open file '$filename' $!";
    while (<$fh>) {
      if (/\$/) {
        my $res = $_;
        if($res) {
          $res =~ s/\_\{(\w+)\}\_/$lang{$1}/sg;
          $res =~ s/\{secretkey\}//g;
          $res =~ s/\{dbpasswd\}//g;
          $res = eval " \"$res\" " if($res !~ /\`/);
          $tpl_content .= $res || q{};
        }
      }
      else {
        s/\_\{(\w+)\}\_/$lang{$1}/sg;
        $tpl_content .= $_;
      }
    }
  close($fh);

  return $tpl_content;
}

#**********************************************************
=head2 templates($tpl_name) - Show template

  Arguments:
    $tpl_name

  Return:
    tpl content

=cut
#**********************************************************
sub templates {
  my ($tpl_name) = @_;

  if(! $conf{base_dir}) {
    $conf{base_dir} = '/usr/onlytest/';
  }

  my @search_paths = (
    $conf{base_dir} . "/templates/$tpl_name" . ".tpl",
  );

  foreach my $tpl ( @search_paths ) {
    if (-f $tpl) {
      return tpl_content($tpl);
    }
  };

  return "No such template [$tpl_name]";
}

1
