package Module::Build::CheckLib;
use strict;
use warnings;
our $VERSION = '0.10';
use parent qw/Module::Build/;

sub new {
    my $invocant = shift;
    my $class = ref $invocant || $invocant;
    my %args = @_;

    my $self = $class->SUPER::new(%args);

    unless ($self->have_c_compiler) {
        warn "This distribution requires a C compiler, but it's not available, stopped.(OS unsupported)\n";
        exit -1;
    }

    require Devel::CheckLib;

    my %opts;
    for my $key (qw/lib libpath LIBS debug header incpath INC libpath ccflags ldflags header function/) {
        if (exists $self->{$key}) {
            $opts{$key} = $self->{$key};
        }
    }
    Devel::CheckLib::check_lib_or_exit(%opts);
}

1;
__END__

=encoding utf-8

=head1 NAME

Module::Build::CheckLib - It's new $module

=head1 SYNOPSIS

    use Module::Build::CheckLib;

=head1 DESCRIPTION

This is a wrapper module for Devel::CheckLib.

=head1 LICENSE

Copyright (C) K.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

K E<lt>x00.x7f@gmail.comE<gt>

=cut

