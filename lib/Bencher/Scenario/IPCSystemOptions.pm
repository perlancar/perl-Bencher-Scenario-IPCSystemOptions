package Bencher::Scenario::IPCSystemOptions;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

our $scenario = {
    summary => "Measure the overhead of IPC::System::Options's system()".
        "over CORE::system()",
    default_precision => 0.001,
    participants => [
        {
            name => 'core-true',
            code => sub {
                system {"/bin/true"} "/bin/true";
            },
        },
        {
            name => 'iso-true',
            module => 'IPC::System::Options',
            code => sub {
                IPC::System::Options::system({shell=>0}, "/bin/true");
            },
        },
        {
            name => 'core-perl',
            code => sub {
                system {$^X} $^X, "-e1";
            },
        },
        {
            name => 'iso-perl',
            module => 'IPC::System::Options',
            code => sub {
                IPC::System::Options::system({shell=>0}, $^X, "-e1");
            },
        },
    ],
};

1;
# ABSTRACT:

=head1 DESCRIPTION

Conclusion: Testing on my system (L<IPC::System::Options> 0.24, perl: 5.22.0,
CPU: Intel(R) Core(TM) i5-2400 CPU @ 3.10GHz (4 cores)) shows the overhead to be
~40μs (0.04ms) so for benchmarking commands that have overhead in the range of
10-100ms we normally don't need to worry about the overhead of
IPC::System::Option (0.04-0.4%) when we are using default precision (~1%).
