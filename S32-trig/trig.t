use v6;
use Test;
plan 214;

# L<S29/"The :Trig tag">

=begin description

Basic tests for trigonometric functions.

=end description

#?rakudo emit #
use Num :Trig;

# See also: L<"http://theory.cs.iitm.ernet.in/~arvindn/pi/"> :)
my $PI = 3.14159265358979323846264338327950288419716939937510;

# -- pi
is_approx(pi, $PI, "pi()");
is_approx(pi + 3, $PI + 3, "'pi() + 3' may drop its parentheses before +3");

# -- atan
# The basic form of atan (one argument) returns a value in ]-pi, pi[.
# Quadrants I, III
is_approx(atan(1)           / $PI * 180, 45);
is_approx(atan(1/3*sqrt(3)) / $PI * 180, 30);
is_approx(atan(sqrt(3))     / $PI * 180, 60);

# Quadrants II, IV
is_approx(atan(-1)           / $PI * 180, -45);
is_approx(atan(-1/3*sqrt(3)) / $PI * 180, -30);
is_approx(atan(-sqrt(3))     / $PI * 180, -60);

is_approx(atan(Inf),   $PI / 2, 'arctan approaches pi/2 as x -> Inf' );
is_approx(atan(-Inf), -$PI / 2, 'arctan approaches -pi/2 as x-> -Inf' );

# S29: C<atan2> computes the arctangent of $y/$x, and
# **takes the quadrant into account**. The second argument is
# assumed to be 1 if it is not present.
# Quadrant I
is_approx(atan2(1, 1)           / $PI * 180, 45);
is_approx(atan2(1)              / $PI * 180, 45);
is_approx(atan2(1, sqrt(3))     / $PI * 180, 30);
is_approx(atan2(1, 1/3*sqrt(3)) / $PI * 180, 60);

# Quadrant II
is_approx(atan2(1, -1)           / $PI * 180, 135);
is_approx(atan2(1, -1/3*sqrt(3)) / $PI * 180, 120);
is_approx(atan2(1, -sqrt(3))     / $PI * 180, 150);

# Quadrant III
is_approx(atan2(-1, -1)           / $PI * 180 + 360, 225);
is_approx(atan2(-1, -sqrt(3))     / $PI * 180 + 360, 210);
is_approx(atan2(-1, -1/3*sqrt(3)) / $PI * 180 + 360, 240);

# Quadrant IV
is_approx(atan2(-1, 1)           / $PI * 180 + 360, 315);
is_approx(atan2(-1)              / $PI * 180 + 360, 315);
is_approx(atan2(-1, sqrt(3))     / $PI * 180 + 360, 330);
is_approx(atan2(-1, 1/3*sqrt(3)) / $PI * 180 + 360, 300);

# -- sin, cos, tan
# sin
is_approx(sin(0/4*$PI), 0);
is_approx(sin(1/4*$PI), 1/2*sqrt(2));
is_approx(sin(2/4*$PI), 1);
is_approx(sin(3/4*$PI), 1/2*sqrt(2));
is_approx(sin(4/4*$PI), 0);
is_approx(sin(5/4*$PI), -1/2*sqrt(2));
is_approx(sin(6/4*$PI), -1);
is_approx(sin(7/4*$PI), -1/2*sqrt(2));
is_approx(sin(8/4*$PI), 0);
is(sin(Inf), NaN);
is(sin(-Inf), NaN);

# cos
is_approx(cos(0/4*$PI), 1);
is_approx(cos(1/4*$PI), 1/2*sqrt(2));
is_approx(cos(2/4*$PI), 0);
is_approx(cos(3/4*$PI), -1/2*sqrt(2));
is_approx(cos(4/4*$PI), -1);
is_approx(cos(5/4*$PI), -1/2*sqrt(2));
is_approx(cos(6/4*$PI), 0);
is_approx(cos(7/4*$PI), 1/2*sqrt(2));
is_approx(cos(8/4*$PI), 1);
is(cos(Inf), NaN);
is(cos(-Inf), NaN);

# tan
is_approx(tan(0/4*$PI),  0);
is_approx(tan(1/4*$PI),  1);
is_approx(tan(3/4*$PI), -1);
is_approx(tan(4/4*$PI),  0);
is_approx(tan(5/4*$PI),  1);
is_approx(tan(7/4*$PI), -1);
is_approx(tan(8/4*$PI),  0);
is(tan(Inf), NaN);
is(tan(-Inf), NaN);


# sec
is_approx(sec(0),    1);
is_approx(sec($PI), -1);
is(sec(Inf), NaN);
is(sec(-Inf), NaN);


# asin
is_approx(asin(0),            0);
#?pugs 2 todo 'feature'
is_approx(asin(1/2*sqrt(2)),  1/4*$PI);
is_approx(asin(1),            2/4*$PI);

# acos
#?pugs 2 todo 'feature'
is_approx(acos(0),            2/4*$PI);
is_approx(acos(1/2*sqrt(2)),  1/4*$PI);
is_approx(acos(1),            0/4*$PI);


# cosh
is_approx( cosh(0), 1);
is_approx( cosh(1), 0.5*(exp(1) + exp(-1)) );
is(cosh(Inf), Inf);
is(cosh(-Inf), Inf);

# sinh
is_approx( sinh(0), 0);
is_approx( sinh(1), 0.5*(exp(1) - exp(-1)) );
is(sinh(Inf), Inf);
is(sinh(-Inf), -Inf);

# asinh
is_approx( asinh(0), 0 );

# acosh
is_approx( acosh(1), 0 );

# tanh
is_approx( tanh(0), 0);
is_approx( tanh(1), sinh(1)/cosh(1) );

# atanh
is_approx( atanh(0), 0 );

# sech
is_approx( sech(0), 1 );

# cosech
is_approx( cosech(2), 1/sinh(2) );

# cotanh
is_approx( cotanh(1), 1/tanh(1) );

# asech
is_approx( asech(1), 0 );

#?rakudo skip 'named args'
{

# -- atan
# The basic form of atan (one argument) returns a value in ]-pi, pi[.
# Quadrants I, III
is_approx(atan(:x(1))           / $PI * 180, 45);
is_approx(atan(:x(1/3*sqrt(3))) / $PI * 180, 30);
is_approx(atan(:x(sqrt(3)))     / $PI * 180, 60);

# Quadrants II, IV
is_approx(atan(:x(-1))           / $PI * 180, -45);
is_approx(atan(:x(-1/3*sqrt(3))) / $PI * 180, -30);
is_approx(atan(:x(-sqrt(3)))     / $PI * 180, -60);

# S29: C<atan2> computes the arctangent of $y/$x, and
# **takes the quadrant into account**. The second argument is
# assumed to be 1 if it is not present.
# Quadrant I
is_approx(atan2(:x(1), 1)           / $PI * 180, 45);
is_approx(atan2(:x(1))              / $PI * 180, 45);
is_approx(atan2(:x(1), sqrt(3))     / $PI * 180, 30);
is_approx(atan2(:x(1), 1/3*sqrt(3)) / $PI * 180, 60);

# Quadrant II
is_approx(atan2(:x(1), -1)           / $PI * 180, 135);
is_approx(atan2(:x(1), -1/3*sqrt(3)) / $PI * 180, 120);
is_approx(atan2(:x(1), -sqrt(3))     / $PI * 180, 150);

# Quadrant III
is_approx(atan2(x => -1, -1)           / $PI * 180 + 360, 225);
is_approx(atan2(x => -1, -sqrt(3))     / $PI * 180 + 360, 210);
is_approx(atan2(x => -1, -1/3*sqrt(3)) / $PI * 180 + 360, 240);

# Quadrant IV
is_approx(atan2(x => -1, 1)           / $PI * 180 + 360, 315);
is_approx(atan2(x => -1)              / $PI * 180 + 360, 315);
is_approx(atan2(x => -1, sqrt(3))     / $PI * 180 + 360, 330);
is_approx(atan2(x => -1, 1/3*sqrt(3)) / $PI * 180 + 360, 300);

# -- sin, cos, tan
# sin
is_approx(sin(:x(0/4*$PI)), 0);
is_approx(sin(:x(1/4*$PI)), 1/2*sqrt(2));
is_approx(sin(:x(2/4*$PI)), 1);
is_approx(sin(:x(3/4*$PI)), 1/2*sqrt(2));
is_approx(sin(:x(4/4*$PI)), 0);
is_approx(sin(:x(5/4*$PI)), -1/2*sqrt(2));
is_approx(sin(:x(6/4*$PI)), -1);
is_approx(sin(:x(7/4*$PI)), -1/2*sqrt(2));
is_approx(sin(:x(8/4*$PI)), 0);

# cos
is_approx(cos(:x(0/4*$PI)), 1);
is_approx(cos(:x(1/4*$PI)), 1/2*sqrt(2));
is_approx(cos(:x(2/4*$PI)), 0);
is_approx(cos(:x(3/4*$PI)), -1/2*sqrt(2));
is_approx(cos(:x(4/4*$PI)), -1);
is_approx(cos(:x(5/4*$PI)), -1/2*sqrt(2));
is_approx(cos(:x(6/4*$PI)), 0);
is_approx(cos(:x(7/4*$PI)), 1/2*sqrt(2));
is_approx(cos(:x(8/4*$PI)), 1);

# tan
is_approx(tan(:x(0/4*$PI)),  0);
is_approx(tan(:x(1/4*$PI)),  1);
is_approx(tan(:x(3/4*$PI)), -1);
is_approx(tan(:x(4/4*$PI)),  0);
is_approx(tan(:x(5/4*$PI)),  1);
is_approx(tan(:x(7/4*$PI)), -1);
is_approx(tan(:x(8/4*$PI)),  0);

# sec
is_approx(sec(:x(0)),    1);
is_approx(sec(:x($PI)), -1);


# asin
is_approx(asin(:x(0)),            0);
#?pugs 2 todo 'feature'
is_approx(asin(:x(1/2*sqrt(2))),  1/4*$PI);
is_approx(asin(:x(1)),            2/4*$PI);

# acos
#?pugs 2 todo 'feature'
is_approx(acos(:x(0)),            2/4*$PI);
is_approx(acos(:x(1/2*sqrt(2))),  1/4*$PI);
is_approx(acos(:x(1)),            0/4*$PI);


# cosh
is_approx( cosh(:x(0)), 1);
is_approx( cosh(:x(1)), 0.5*(exp(1) + exp(-1)) );

# sinh
is_approx( sinh(:x(0)), 0);
is_approx( sinh(:x(1)), 0.5*(exp(1) - exp(-1)) );

# asinh
is_approx( asinh(:x(0)), 0 );

# acosh
is_approx( acosh(:x(1)), 0 );

# tanh
is_approx( tanh(:x(0)), 0);
is_approx( tanh(:x(1)), sinh(1)/cosh(1) );

# atanh
is_approx( atanh(:x(0)), 0 );

# sech
is_approx( sech(:x(0)), 1 );

# cosech
is_approx( cosech(:x(2)), 1/sinh(2) );

# cotanh
is_approx( cotanh(:x(1)), 1/tanh(1) );

# asech
is_approx( asech(:x(1)), 0 );
# -- atan
# The basic form of atan (one argument) returns a value in ]-pi, pi[.
# Quadrants I, III
is_approx(atan(:x(1))           / $PI * 180, 45);
is_approx(atan(:x(1/3*sqrt(3))) / $PI * 180, 30);
is_approx(atan(:x(sqrt(3)))     / $PI * 180, 60);

# Quadrants II, IV
is_approx(atan(:x(-1))           / $PI * 180, -45);
is_approx(atan(:x(-1/3*sqrt(3))) / $PI * 180, -30);
is_approx(atan(:x(-sqrt(3)))     / $PI * 180, -60);

# S29: C<atan2> computes the arctangent of $y/$x, and
# **takes the quadrant into account**. The second argument is
# assumed to be 1 if it is not present.
# Quadrant I
is_approx(atan2(x => 1, 1)           / $PI * 180, 45);
is_approx(atan2(:x(1))              / $PI * 180, 45);
is_approx(atan2(x => 1, sqrt(3))     / $PI * 180, 30);
is_approx(atan2(x => 1, 1/3*sqrt(3)) / $PI * 180, 60);

# Quadrant II
is_approx(atan2(x => 1, -1)           / $PI * 180, 135);
is_approx(atan2(x => 1, -1/3*sqrt(3)) / $PI * 180, 120);
is_approx(atan2(x => 1, -sqrt(3))     / $PI * 180, 150);

# Quadrant III
is_approx(atan2(x => -1, -1)           / $PI * 180 + 360, 225);
is_approx(atan2(x => -1, -sqrt(3))     / $PI * 180 + 360, 210);
is_approx(atan2(x => -1, -1/3*sqrt(3)) / $PI * 180 + 360, 240);

# Quadrant IV
is_approx(atan2(x => -1, 1)           / $PI * 180 + 360, 315);
is_approx(atan2(x => -1)              / $PI * 180 + 360, 315);
is_approx(atan2(x => -1, sqrt(3))     / $PI * 180 + 360, 330);
is_approx(atan2(x => -1, 1/3*sqrt(3)) / $PI * 180 + 360, 300);

# -- sin, cos, tan
# sin
is_approx(sin(:x(0/4*$PI)), 0);
is_approx(sin(:x(1/4*$PI)), 1/2*sqrt(2));
is_approx(sin(:x(2/4*$PI)), 1);
is_approx(sin(:x(3/4*$PI)), 1/2*sqrt(2));
is_approx(sin(:x(4/4*$PI)), 0);
is_approx(sin(:x(5/4*$PI)), -1/2*sqrt(2));
is_approx(sin(:x(6/4*$PI)), -1);
is_approx(sin(:x(7/4*$PI)), -1/2*sqrt(2));
is_approx(sin(:x(8/4*$PI)), 0);

# cos
is_approx(cos(:x(0/4*$PI)), 1);
is_approx(cos(:x(1/4*$PI)), 1/2*sqrt(2));
is_approx(cos(:x(2/4*$PI)), 0);
is_approx(cos(:x(3/4*$PI)), -1/2*sqrt(2));
is_approx(cos(:x(4/4*$PI)), -1);
is_approx(cos(:x(5/4*$PI)), -1/2*sqrt(2));
is_approx(cos(:x(6/4*$PI)), 0);
is_approx(cos(:x(7/4*$PI)), 1/2*sqrt(2));
is_approx(cos(:x(8/4*$PI)), 1);

# tan
is_approx(tan(:x(0/4*$PI)),  0);
is_approx(tan(:x(1/4*$PI)),  1);
is_approx(tan(:x(3/4*$PI)), -1);
is_approx(tan(:x(4/4*$PI)),  0);
is_approx(tan(:x(5/4*$PI)),  1);
is_approx(tan(:x(7/4*$PI)), -1);
is_approx(tan(:x(8/4*$PI)),  0);

# sec
is_approx(sec(:x(0)),    1);
is_approx(sec(:x($PI)), -1);


# asin
is_approx(asin(:x(0)),            0);
#?pugs 2 todo 'feature'
is_approx(asin(:x(1/2*sqrt(2))),  1/4*$PI);
is_approx(asin(:x(1)),            2/4*$PI);

# acos
#?pugs 2 todo 'feature'
is_approx(acos(:x(0)),            2/4*$PI);
is_approx(acos(:x(1/2*sqrt(2))),  1/4*$PI);
is_approx(acos(:x(1)),            0/4*$PI);


# cosh
is_approx( cosh(:x(0)), 1);
is_approx( cosh(:x(1)), 0.5*(exp(1) + exp(-1)) );

# sinh
is_approx( sinh(:x(0)), 0);
is_approx( sinh(:x(1)), 0.5*(exp(1) - exp(-1)) );

# asinh
is_approx( asinh(:x(0)), 0 );

# acosh
is_approx( acosh(:x(1)), 0 );

# tanh
is_approx( tanh(:x(0)), 0);
is_approx( tanh(:x(1)), sinh(1)/cosh(1) );

# atanh
is_approx( atanh(:x(0)), 0 );

# sech
is_approx( sech(:x(0)), 1 );

# cosech
is_approx( cosech(:x(2)), 1/sinh(2) );

# cotanh
is_approx( cotanh(:x(1)), 1/tanh(1) );

# asech
is_approx( asech(:x(1)), 0 );
}