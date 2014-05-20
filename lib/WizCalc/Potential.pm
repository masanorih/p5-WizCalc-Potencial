package WizCalc::Potential;

use warnings;
use strict;
#use Data::Dumper; $Data::Dumper::Sortkeys = 1;
use Carp;
use Exporter 'import';
our @EXPORT = qw(calc_potential);

use version; our $VERSION = qv('0.0.2');

=pod

最終目標である最高ランク、潜在能力全開放状態のカード(X)を得るために
必要最低限のカードは何枚か。

=cut

sub calc_potential {
    my(@potencial) = @_;

    my( $max_potencial, $rmax ) = max_potencial(@potencial);
    #warn "max_potencial = " . Dumper $rmax;
    my $ev_cost = scalar @potencial * 2;
    my $costs = potencial_cost($rmax);
    # is even
    if ( 0 == $max_potencial % 2 ) {
        my $half   = $max_potencial / 2;
        my $p_cost = $costs->{$half} + $costs->{ $half - 1 };
        return $ev_cost + $p_cost;
    }
    else {
        my $half   = int $max_potencial / 2;
        my $p_cost = $costs->{$half} + $costs->{ $half + 1 };
        return $ev_cost + $p_cost;
    }

    #my $result;
    #for my $i ( 1 .. $max_potencial ) {
    #    my $n = $rmax->{$i};
    #    #warn "n = $n";
    #    my $y = $n * 2 + 1;
    #    my $ncost = $n + $i - 1;
    #    if ( $max_potencial == $y ) {
    #        #warn "max_potencial($max_potencial) == y($y)";
    #        $result = ( $ev_cost + $ncost ) * 2;
    #        last;
    #    }
    #    elsif ( $max_potencial < $y ) {
    #        #warn "max_potencial($max_potencial) < y($y)";
    #        my $o = $y - $ncost;
    #        #warn "i = $i, n = $n";
    #        #warn "ncost = $ncost, o = $o";
    #        $result = ( $ev_cost + $ncost ) * 2 - $o;
    #        last;
    #    }
    #    #warn "max_potencial($max_potencial) > y($y)";
    #}
    ##warn "result = $result";
    #$result;
}

# potencial => rank
sub max_potencial {
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
    return( $max_potencial, $rmax );
}

# potencial => cost,
sub potencial_cost {
    my $rmax = shift;
    my $potencial_cost;
    my $p_rank;
    my $p_cost;
    for my $pot ( sort keys %{$rmax} ) {
        my $rank = $rmax->{$pot};
        if ($p_rank) {
            if ( $rank == $p_rank ) {
                $potencial_cost->{$pot} = $p_cost + 1;
                $p_cost = $potencial_cost->{$pot};
            }
            else {
                my $diff = $rank - $p_rank;
                if ( 1 == $diff ) {
                    $potencial_cost->{$pot} = $p_cost + 1 + $diff;
                }
                $p_rank = $rank;
            }
        }
        else {
            $potencial_cost->{$pot} = $rank;
            $p_rank = $rank;
            $p_cost = $potencial_cost->{$pot};
        }
        last if $pot == 3;
    }
    return $potencial_cost;
}

1;
__END__

=head1 NAME

WizCalc::Potential - 猫Wiz イベントカード(進化素材が自分自身)潜在能力開放計算式


=head1 VERSION

This document describes WizCalc::Potential version 0.0.2


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

    各グレードの最大潜在能力を入力すると、
    最終ランク(通常はS)の潜在能力全開放に必要な素のカード枚数を返す。

=over

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
