#!/usr/bin/env perl

use strict;
use warnings;
use 5.10.0;

use Cwd;
use File::Basename;
use Text::Markdown::Discount;

# Enable html5 block-level tags:
Text::Markdown::Discount::with_html5_tags();
my $flags = Text::Markdown::Discount::MKD_EXTRA_FOOTNOTE();
my $markdown = Text::Markdown::Discount->new;

my $cwd = Cwd::getcwd();

my $full_source = '';
while (my $source = get_input()) {
  # A simple preprocessor:
  my ($basename, $dir) = fileparse($ARGV); # get path of target file
  chdir $dir;
  $source =~ s{<!-- exec -->(.*?)<!-- end -->}{handle_block($1);}egs;
  chdir $cwd;

  my $a_name = $dir;
  $a_name =~ s/[^a-z]+/-/ig;
  $a_name =~ s/^-|-$//g;

  $full_source .= ($a_name ? "\n\n<a name=$a_name></a>" : '') . $source;
}

my $rendered = $markdown->markdown($full_source, $flags);

# Bold command line examples (SUPER CHEESY):
$rendered =~ s{(\$ .*?)$}{<b>$1</b>}gm;

print $rendered;

sub get_input {
  local $/ = undef;
  my $source = <>;
  return $source;
}

sub handle_block {
  my ($block) = @_;

  my $cmd;

  if ($block =~ m/\$ (.*?)$/m) {
    $cmd = $1;
  } else {
    die "bogus cmd";
  }

  my $result = `$cmd`;

  # indent 4 spaces so we get a code block:
  $result =~ s/^/    /gm;

  return "<!-- exec -->\n\n    \$ " . $cmd . "\n" . $result . "\n<!-- end -->";
}

sub get_file {
  my ($filename) = @_;
  local $/ = undef;
  open my $fh, '<', $filename;
  return <$fh>;
}
