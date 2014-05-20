use strict;
use warnings;
use Test::More;
use WizCalc::Potential;

is( calc_potential( 1, 2, 4 ), 10,
    '#1595 功夫の達人リンシン・ファン     = 10' );
is( calc_potential( 1, 2, 3, 5 ), 14,
    '#1661 氷を戴く女王レリア・フェリズ   = 14' );
is( calc_potential( 1, 2, 3, 4 ), 12,
    '#1662 奸智の梟雄ユング・アーレンス   = 12' );
is( calc_potential( 2, 3, 4, 6 ), 14,
    '#1764 一箭聖心イングリット・レイ     = 14' );
#is( calc_potential( 1, 2, 4, 6 ), 16,
#    '#XXXX 銃士魔女マダム・ヴァイオレッタ = 16' );

#1595 功夫の達人リンシン・ファン     = 10
#my $rmax = {
#          '1' => 1,
#          '2' => 2,
#          '3' => 3,
#          '4' => 3
#        };
#XXXX 一箭聖心イングリット・レイ     = 14
#my $rmax = {
#          '1' => 1,
#          '2' => 1,
#          '3' => 2,
#          '4' => 3,
#          '5' => 4,
#          '6' => 4
#        };
#XXXX 銃士魔女マダム・ヴァイオレッタ = 16
#my $rmax = {
#          '1' => 1,
#          '2' => 2,
#          '3' => 3,
#          '4' => 3,
#          '5' => 4,
#          '6' => 4
#        };
#
#
#my $ref = WizCalc::Potential::potencial_cost($rmax);
#use Data::Dumper; warn Dumper $ref;
#
#$VAR1 = {
#          '1' => 1,
#          '2' => 3,
#          '3' => 3
#        };
## should be
#$VAR1 = {
#          '1' => 1,
#          '2' => 3,
#          '3' => 6
#        };

done_testing;
