#!/usr/bin/env perl

use warnings;
use strict;
use 5.10.0;
use XML::Atom::SimpleFeed;
use HTML::Entities;
use Getopt::Long;
use POSIX qw(strftime);

# this is awesome:
use IPC::System::Simple qw(capturex);

# figure out where top-level .git resides:
my $repo_base = git('rev-parse', '--show-toplevel');
chomp($repo_base);

# initial values for config options

my $title = 'git log';
$title = slurp("$repo_base/.git/description")
  if (-f "$repo_base/.git/description");

my $author = git_config('user.name');
chomp($author);

my $feed_link = git_config('feed.link');
my $project_link = git_config('feed.projectlink');
my $entries = 10;

GetOptions(
  "author:s"       => \$author,
  "entries:i"      => \$entries,
  "feed_link:s"    => \$feed_link,
  "project_link:s" => \$project_link,
  "title:s"        => \$title,
);

# where does this project live on the web?
unless ($project_link) {
  say "Project link required - use one of:";
  say "\tgit feed --project_link=https://yourlinkhere/";
  say "\tgit config feed.projectlink https://yourlinkhere/";
  exit(1);
}

# no feed link set?  Make something up.
unless ($feed_link) {
  $feed_link = $project_link . 'feed.xml';
}

my $log = capturex('git', 'log', "-$entries", qq{--pretty=format:%H _ %ai _ %s});

my $feed = XML::Atom::SimpleFeed->new(
  title     => $title,
  link      => $project_link,
  link      => { rel => 'self', href => $feed_link, },
  author    => $author,
  id        => $project_link,
  generator => 'XML::Atom::SimpleFeed',

  # this could be better - just uses current time, at the moment:
  updated   => iso_date(time()),
);

while ($log =~ m/^([a-z0-9]+) _ (.*) _ (.*)$/gm) {
  my $hash = $1;
  my $full_commit = git('show', $hash);
  my $formatted_commit = '<pre>' . encode_entities($full_commit) . '</pre>';
  my $date = $2;
  my $subj = $3;

  $feed->add_entry(
    title     => $subj,
    link      => $project_link,
    id        => $hash,
    content   => $formatted_commit,
    updated   => $date,
  );
}

print $feed->as_string;

sub iso_date {
  my ($time) = @_;
  return strftime("%Y-%m-%dT%H:%M:%SZ", localtime($time));
}

# get the contents of a file
sub slurp {
  my ($file) = @_;
  my $everything;

  open my $fh, '<', $file
    or die "Couldn't open $file: $!\n";

  # line separator:
  local $/ = undef;
  $everything = <$fh>;

  close $fh
    or die "Couldn't close: $!";

  return $everything;
}

# run git with some options, return result
sub git { capturex('git', @_); }

sub git_config {
  my ($key) = @_;
  my $value = capturex([0,1], 'git', 'config', '--get', $key);
  chomp($value);
}
