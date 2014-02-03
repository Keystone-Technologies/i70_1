package I70::Plugin::EMR;
use Mojo::Base 'Mojolicious::Plugin';

our $VERSION = "0.01";

sub register {
  my ($self, $app, $conf) = @_;
  my $loader = Mojo::Loader->new;
  for my $module (@{$loader->search(__PACKAGE__)}) {
    $app->plugin($module);
  }
  $app->helper(j => sub { shift; Mojo::JSON::j(@_) });
  $app->hook(before_render => sub {
    my ($self, $args) = @_;
    # Implement this hook for development mode only 
    return unless $self->app->mode eq 'development';   
    # Make sure we are rendering the exception template
    return unless my $template = $args->{template};
    if ( $template eq 'exception' ) {
      # Switch to JSON rendering if content negotiation allows it
      $args->{json} = {exception => $self->stash('exception')} if scalar $self->req->headers->header('User-Agent') =~ /^curl|^Mojolicious/;
    } elsif ( $template eq 'not_found' ) {
      # Switch to JSON rendering if content negotiation allows it
      $args->{json} = {not_found => $self->stash('not_found')} if scalar $self->req->headers->header('User-Agent') =~ /^curl|^Mojolicious/;
    }
  });
  $app->hook(after_render => sub {
    my ($self, $args) = @_;
    # Implement this hook for development mode only 
    return unless $self->app->mode eq 'development';   
    $$args .= "\n" if scalar $self->req->headers->header('User-Agent') =~ /^curl|^Mojolicious/;
  });
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
