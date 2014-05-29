#!/usr/bin/env perl

use warnings;
use strict;
use 5.10.0;
use XML::Atom::SimpleFeed;
use HTML::Entities;

my $book_url = "http://www.p1k3.com/userland-book/";
my $feed_url = "http://www.p1k3.com/userland-book/feed.xml";

my $log = `git log -10 --pretty=format:"%H _ %ai _ %s"`;

my $feed = XML::Atom::SimpleFeed->new(
  title     => "userland: a book about the command line for humans",
  link      => $book_url,
  link      => { rel => 'self', href => $feed_url, },
  author    => 'Brennen Bearnes',
  id        => $book_url,
  generator => 'XML::Atom::SimpleFeed',
  # updated   => iso_date(Wala::get_mtime($month_file)),
);

while ($log =~ m/^([a-z0-9]+) _ (.*) _ (.*)$/gm) {
  my $hash = $1;
  my $full_commit = `git show $hash`;
  my $formatted_commit = '<pre>' . encode_entities($full_commit) . '</pre>';
  my $date = $2;
  my $subj = $3;

  $feed->add_entry(
    title     => $subj,
    link      => $book_url,
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
