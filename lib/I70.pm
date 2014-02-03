package I70;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  $self->plugin('PQGridCrud');
  $self->plugin('RESTRoutes');
  $self->plugin('I70::Plugin::EMR');

  my $r = $self->routes;
  $r->get('/')->to('example#welcome');
}

1;
