# vim: set ts=2 sts=2 sw=2 expandtab smarttab:
use strict;
use warnings;
use Test::More tests => 1;
use Test::Differences;
use Pod::Markdown;

my $pod_prefix = 'http://search.cpan.org/perldoc?';

my $parser = Pod::Markdown->new;
$parser->parse_from_filehandle(\*DATA);
my $markdown = $parser->as_markdown;
my $expect = <<EOMARKDOWN;
# NAME

pod2markdown - Convert POD text to Markdown

# SYNOPSIS

    \$ pod2markdown < POD_File > Markdown_File

# DESCRIPTION

This program uses [Pod::Markdown](${pod_prefix}Pod::Markdown) to convert POD into Markdown sources. It is
a filter that expects POD on STDIN and outputs Markdown on STDOUT.

FTP is at [ftp://ftp.univie.ac.at/foo/bar](ftp://ftp.univie.ac.at/foo/bar).

HTTP is at [http://univie.ac.at/baz/](http://univie.ac.at/baz/).

# SEE ALSO

This program is strongly based on `pod2mdwn` from [Module::Build::IkiWiki](${pod_prefix}Module::Build::IkiWiki).

And see ["foobar"](#foobar) as well.

# MORE TESTS

## _Italics_, __Bold__, `Code`, and [Links](${pod_prefix}Links) should work in headers

_Italics_, __Bold__, `Code`, and [Links](${pod_prefix}Links) should work in body text.

__Nested `codes`__ work, too

- This
- is
- a

basic

- bulleted

item

- list
- test

# Links

[Formatting `C`odes](${pod_prefix}Links#L<...>)
EOMARKDOWN

1 while chomp $markdown;
1 while chomp $expect;

eq_or_diff $markdown, $expect, "this file's POD as markdown";

__DATA__
=head1 NAME

pod2markdown - Convert POD text to Markdown

=head1 SYNOPSIS

    $ pod2markdown < POD_File > Markdown_File

=head1 DESCRIPTION

This program uses L<Pod::Markdown> to convert POD into Markdown sources. It is
a filter that expects POD on STDIN and outputs Markdown on STDOUT.

FTP is at L<ftp://ftp.univie.ac.at/foo/bar>.

HTTP is at L<http://univie.ac.at/baz/>.

=head1 SEE ALSO

This program is strongly based on C<pod2mdwn> from L<Module::Build::IkiWiki>.

And see L</foobar> as well.

=head1 MORE TESTS

=head2 I<Italics>, B<Bold>, C<Code>, and L<Links> should work in headers

I<Italics>, B<Bold>, C<Code>, and L<Links> should work in body text.

B<< Nested C<codes> >> work, too

=over 4

=item *

This

=item *	is

=item	* a

basic

=item *

bulleted

item

=item *

list

=item * test

=back

=head1 Links

L<<< FormattZ<>ing C<C>odes|Links/"LE<lt>...E<gt>" >>>
