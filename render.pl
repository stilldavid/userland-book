#!/usr/bin/env perl

use strict;
use warnings;
use 5.10.0;

use Text::Markdown::Discount;

# enable html5 block-level tags
Text::Markdown::Discount::with_html5_tags();
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

# Include global links:
$source .= "\n" . get_file('./links.md') if (-e './links.md');
$source .= "\n" . get_file('../links.md') if (-e '../links.md');

my $rendered = $markdown->markdown($source, $flags);

# Use the first header we can find for a title
my ($title) = $rendered =~ m|<h1>(.*?)</h1>|i;

header($title);
print $rendered;
footer();

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

sub header {
  my ($title) = @_;
  print <<"HTML"
<html>
<head>
  <title>$title</title>
  <link rel=stylesheet href="../userland.css" />
</head>

<body>

HTML
}

sub footer {
  print <<"HTML"

</body>
</html>
HTML
}

sub get_file {
  my ($filename) = @_;
  local $/ = undef;
  open my $fh, '<', $filename;
  return <$fh>;
}
