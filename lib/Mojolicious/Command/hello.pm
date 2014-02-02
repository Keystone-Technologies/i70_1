package Mojolicious::Command::hello;
use Mojo::Base 'Mojolicious::Command';

has description => "Say hello.\n";
has usage => sub { shift->extract_usage };

sub run {
  my ($self, @args) = @_;

  say "Hello, World!";
}

1;

=encoding utf8

=head1 NAME

Mojolicious::Command::hello - hello command

=head1 SYNOPSIS

  Usage: APPLICATION hello

    ./myapp.pl hello

  Options:
    None

=head1 DESCRIPTION

L<Mojolicious::Command::hello> says hello.

=head1 ATTRIBUTES

L<Mojolicious::Command::hello> inherits all attributes from
L<Mojolicious::Command> and implements the following new ones.

=head2 description

  my $description = $hello->description;
  $hello           = $hello->description('Foo!');

Short description of this command, used for the command list.

=head2 usage

  my $usage = $hello->usage;
  $hello     = $hello->usage('Foo!');

Usage information for this command, used for the help screen.

=head1 METHODS

L<Mojolicious::Command::hello> inherits all methods from
L<Mojolicious::Command> and implements the following new ones.

=head2 run

  $hello->run(@ARGV);

Run this command.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=cut