use v6;
use Test;
plan 2;

# L<S29/"List"/"=item map">

my $text  = "abc";
my %ret;

# XXX depends on the Pair stringification which is likely going to change

#?rakudo skip "Awaiting p6l clarification on Hash composer/block"
{
%ret = map { $_ => uc $_; }, split "", $text;
is ~%ret.sort, "a\tA b\tB c\tC", "=> works in a map block";
}

%ret = map { $_, uc $_ }, split "", $text;
is ~%ret.sort, "a\tA b\tB c\tC", "map called with function return values works";