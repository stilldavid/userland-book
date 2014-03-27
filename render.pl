#!/usr/bin/env perl

use strict;
use warnings;
use 5.10.0;

use Text::Markdown::Discount;

my $flags = Text::Markdown::Discount::MKD_EXTRA_FOOTNOTE();
my $markdown = Text::Markdown::Discount->new;

my ($infile) = @ARGV;

my $source;
{
  # grab the whole file/stream by temporarily unsetting the line separator:
  local $/ = undef;
  $source = <>;
}

# A simple preprocessor:
$source =~ s{<!-- exec -->(.*?)<!-- end -->}{handle_block($1);}egs;

say $markdown->markdown($source, $flags);

sub handle_block {
  my ($block) = @_;

  my $cmd;

  if ($block =~ m/\$ (.*?)$/m) {
    $cmd = $1;
  } else {
    die "bogus cmd";
  }

  my $result = `$cmd`;
  $result =~ s/^/    /gm;

  return "<!-- exec -->\n\n    \$ " . $cmd . "\n" . $result . "\n<!-- end -->";
}

