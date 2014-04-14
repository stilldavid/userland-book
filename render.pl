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

  $full_source .= "\n\n----\n\n" . $source;

}

print replace_some_stuff($markdown->markdown($full_source, $flags));

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

# super cheeseball, man
sub replace_some_stuff {
  my ($markup) = @_;

  $markup =~ s{<code>(\$ .*?)$}{<code><b>$1</b>}gm;

  my @contents;

  # insert anchors in headers, accumulate a table of contents
  $markup =~ s{<(h[12])>(.*?)</h[12]>}{
    my ($tag, $text) = ($1, $2);
    my $a_name = $text;
    $a_name =~ s/[^a-z]+/-/ig;
    $a_name =~ s/^-|-$//g;
    push @contents, make_contents_link($tag, $a_name, $text);
    "<$tag><a name=$a_name href=#$a_name>#</a> $text</$tag>";
  }iesg;

  my $contents_text = $markdown->markdown((join "\n", @contents), $flags);
  $markup =~ s/{{contents}}/$contents_text/;

  return $markup;
}

# make an individual element of a markdown list
sub make_contents_link {
  my ($tag, $a_name, $text) = @_;
  if ($tag eq 'h2') {
    return "    * [$text](#$a_name)";
  } elsif ($tag eq 'h1') {
    return "* [$text](#$a_name)";
  }
}
