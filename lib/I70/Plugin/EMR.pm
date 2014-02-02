package I70::Plugin::EMR;
use Mojo::Base 'Mojolicious::Plugin';

our $VERSION = "0.01";

sub register {
  my ($self, $app, $conf) = @_;
  my $loader = Mojo::Loader->new;
  for my $module (@{$loader->search(__PACKAGE__)}) {
    $app->plugin($module);
  }
}

1;
__END__

=encoding utf8

=head1 NAME

Mojolicious::Plugin::PQGridCrud - Mojolicious Plugin to make ParamQuery Grid requests RESTFUL

=head1 SYNOPSIS

  # Mojolicious
  $self->plugin('PQGridCrud');

  # Mojolicious::Lite
  plugin 'PQGridCrud';

=head1 DESCRIPTION

L<Mojolicious::Plugin::PQGridCrud> is a L<Mojolicious> plugin to convert ParamQuery Grid non-REST requests to REST.

=head1 METHODS

L<Mojolicious::Plugin::PQGridCrud> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 register

  $plugin->register(Mojolicious->new);

Register plugin in L<Mojolicious> application.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=cut
