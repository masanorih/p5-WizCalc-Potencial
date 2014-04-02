use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'WizCalc::Potential',
    license             => 'perl',
    dist_author         => 'Masanori Hara <massa.hara at gmail.com>',
    dist_version_from   => 'lib/WizCalc/Potential.pm',
    requires => {
        'Test::More' => 0,
        'version'    => 0,
    },
    add_to_cleanup      => [ 'WizCalc-Potential-*' ],
);

$builder->create_build_script();
