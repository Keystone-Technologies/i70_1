package Mojolicious::Command::deps;
use Mojo::Base 'Mojolicious::Command';

has description => "Install deps into local::lib.\n";
has usage => sub { shift->extract_usage };

sub run {
  my ($self, @args) = @_;
  my $home = $self->app->home;
  say qx {cpanm -L $home/local --installdeps $home};
}

1;

=encoding utf8

=head1 NAME

Mojolicious::Command::eval - Eval command

=head1 SYNOPSIS

  Usage: APPLICATION eval [OPTIONS] CODE

    ./myapp.pl eval 'say app->ua->get("/")->res->body'
    ./myapp.pl eval -v 'app->home'
    ./myapp.pl eval -V 'app->renderer->paths'

  Options:
    -v, --verbose   Print return value to STDOUT.
    -V              Print returned data structure to STDOUT.

=head1 DESCRIPTION

L<Mojolicious::Command::eval> runs code against applications.

This is a core command, that means it is always enabled and its code a good
example for learning to build new commands, you're welcome to fork it.

See L<Mojolicious::Commands/"COMMANDS"> for a list of commands that are
available by default.

=head1 ATTRIBUTES

L<Mojolicious::Command::eval> inherits all attributes from
L<Mojolicious::Command> and implements the following new ones.

=head2 description

  my $description = $eval->description;
  $eval           = $eval->description('Foo!');

Short description of this command, used for the command list.

=head2 usage

  my $usage = $eval->usage;
  $eval     = $eval->usage('Foo!');

Usage information for this command, used for the help screen.

=head1 METHODS

L<Mojolicious::Command::eval> inherits all methods from
L<Mojolicious::Command> and implements the following new ones.

=head2 run

  $eval->run(@ARGV);

Run this command.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=cut