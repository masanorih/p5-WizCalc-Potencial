use strict;
use warnings;
use Test::More;
use WizCalc::Potential;

is( (calc_potential( 1, 2, 4 ))[-1], 10,
    '#1595 功夫の達人リンシン・ファン     = 10' );
is( (calc_potential( 1, 2, 3, 4 ))[-1], 12,
    '#0000 奸智の梟雄ユング・アーレンス   = 12' );
is( (calc_potential( 1, 2, 3, 5 ))[-1], 14,
    '#1661 氷を戴く女王レリア・フェリズ   = 14' );

done_testing;
