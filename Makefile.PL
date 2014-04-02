use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'WizCalc::Potential',
    AUTHOR              => 'Masanori Hara <massa.hara at gmail.com>',
    VERSION_FROM        => 'lib/WizCalc/Potential.pm',
    ABSTRACT_FROM       => 'lib/WizCalc/Potential.pm',
    PL_FILES            => {},
    LICENSE             => 'perl',
    PREREQ_PM => {
        'Test::More' => 0,
        'version'    => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'WizCalc-Potential-*' },
);
