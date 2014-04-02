package WizCalc::Potential;

use warnings;
use strict;
#use Data::Dumper; $Data::Dumper::Sortkeys = 1;
use Carp;
use Exporter 'import';
our @EXPORT = qw(calc_potential);

use version; our $VERSION = qv('0.0.1');


sub calc_potential {
    my(@potencial) = @_;

    my $rmax;
    my $max_potencial = $potencial[-1];
    for my $pot ( 1 .. $max_potencial ) {
        my $i = 0;
        for my $rank_pot (@potencial) {
            $i++;
            if ( $pot <= $rank_pot ) {
                $rmax->{$pot} = $i;
                last;
            }
        }
    }
    #warn "max_potencial = $max_potencial";
    #warn Dumper $rmax;

    my $ev_cost = scalar @potencial;
    # 0..2 is primal
    my @table;
    push @table, $ev_cost;
    push @table, $ev_cost + $rmax->{1};
    push @table, $ev_cost + $potencial[0] + $rmax->{2};
    # for big number it just sum 0-2
    for my $i ( 3 .. $max_potencial ) {
        my $prime_factor = get_prime_factor($i);
        #warn "i=$i " . Dumper $prime_factor;
        my $pot;
        for my $j ( @{$prime_factor} ) {
            $pot += $table[$j];
        }
        push @table, $pot;
    }
    return @table;
}

sub get_prime_factor {
    my $num = shift;
    $num--;

    return( [1, 1] ) if $num == 2;
    my $even = int $num / 2;
    my $one  = $num % 2;

    my @result;
    push @result, 1 if $one;
    push @result, 2 for (1 .. $even);
    return \@result;
}

1;
__END__

=head1 NAME

WizCalc::Potential - 猫Wiz イベントカード(進化素材が自分自身)潜在能力開放計算式


=head1 VERSION

This document describes WizCalc::Potential version 0.0.1


=head1 SYNOPSIS

    use WizCalc::Potential;
    my @result = calc_potential( 1, 2, 4 ));
    print $result[-1]; # 10

=head1 DESCRIPTION

This module provide a caluclator tool for Japanese Android game
L<http://colopl.co.jp/magicianwiz/>.

=head1 INTERFACE 

=for calc_potential

    my @result = calc_potential( 1, 2, 4 ));

    各グレードの最大潜在能力を入力すると、最終クラス(通常はS)の
    潜在能力開放にどれだけの素のカードが必要なのかを
    潜在能力開放数分配列にして返す。

=over

=item C<< Error message here, perhaps with %s placeholders >>

[Description of error here]

=item C<< Another error message here >>

[Description of error here]

[Et cetera, et cetera]

=back


=head1 DEPENDENCIES

None.


=head1 INCOMPATIBILITIES

None reported.


=head1 BUGS AND LIMITATIONS

No bugs have been reported.


=head1 AUTHOR

Masanori Hara  C<< <massa.hara at gmail.com> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2014, Masanori Hara C<< <massa.hara at gmail.com> >>.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
