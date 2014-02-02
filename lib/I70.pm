package I70;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  $self->plugin('PQGridCrud');
  $self->plugin('RESTRoutes');
  $self->plugin('I70::Plugin::EMR');

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('example#welcome');
}

1;
