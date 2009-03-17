use v6;

use Test;

plan 25;

# L<S29/Str/=item comb>

# comb Str
is "".comb, (), 'comb on empty string';
is "a bc d".comb, <a bc d>, 'default matcher and limit';
is " a bc d ".comb, <a bc d>, 'default matcher and limit (leading/trailing ws)';

#?pugs todo 'feature'
#?rakudo skip 'limit for comb'
is "a bc d".comb(:limit(2)), <a bc>, 'default matcher with supplied limit';

#?pugs skip "todo: Str.comb"
{
    my Str $hair = "Th3r3 4r3 s0m3 numb3rs 1n th1s str1ng";
    is $hair.comb(/\d+/), <3 3 4 3 0 3 3 1 1 1>, 'no limit returns all matches';
    #?rakudo skip 'calling positional args by name'
    is comb(:input($hair), /\d+/), <3 3 4 3 0 3 3 1 1 1>, 'comb works with named argument for input';
    is $hair.comb(/\d+/, -10), (), 'negative limit returns no matches';
    is $hair.comb(/\d+/, 0), (), 'limit of 0 returns no matches';
    is $hair.comb(/\d+/, 1), <3>, 'limit of 1 returns 1 match';
    is $hair.comb(/\d+/, 3), <3 3 4>, 'limit of 3 returns 3 matches';
    is $hair.comb(/\d+/, 1000000000), <3 3 4 3 0 3 3 1 1 1>, 'limit of 1 billion returns all matches quickly';
}

{
    my @list =  'split this string'.comb;
    is @list.join('|'), 'split|this|string', 'Str.comb';
}

{
    is "a ab bc ad ba".comb(/\ba\S*/), <a ab ad>,
        'match for any a* words';
    is "a ab bc ad ba".comb(/\S*a\S*/), <a ab ad ba>,
        'match for any *a* words';
}

{
    is "a ab bc ad ba".comb(/<< a\S*/), <a ab ad>,
        'match for any a* words';
    is "a ab bc ad ba".comb(/\S*a\S*/), <a ab ad ba>,
        'match for any *a* words';
}

#?pugs todo 'feature'
is "a ab bc ad ba".comb(/\S*a\S*/, 2), <a ab>, 'matcher and limit';

is "forty-two".comb(/./).join('|'), 'f|o|r|t|y|-|t|w|o', q{Str.comb(/./)};

isa_ok("forty-two".comb(/./), List);

# comb a list

#?pugs todo 'feature'
#?rakudo skip 'm:Perl5'
is eval('(<a ab>, <bc ad ba>).comb(m:Perl5/\S*a\S*/)'), <a ab ad ba>,
     'comb a list';

# needed: comb a filehandle

{
    my @l = 'a23 b c58'.comb(/\w(\d+)/);
    is @l.join('|'), 'a23|c58', 'basic comb-with-matches sanity';
    isa_ok(@l[0], Match, 'first item is a Match');
    isa_ok(@l[1], Match, 'second item is a Match');
    #?rakudo todo 'PGE: bind to values, not containers'
    is @l[0].to, 2, '.to of the first item is correct';
    #?rakudo todo 'pos-preserving .comb'
    is @l[1].to, 8, '.to of the second item is correct';
}
