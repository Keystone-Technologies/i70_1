package I70;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  $self->plugin('PQGridCrud');
  $self->plugin('RESTRoutes');
  $self->plugin('I70::Plugin::EMR');
  $self->app->hook(after_render => sub { ${$_[1]} .= "\n" }); # Append \n to all rendered output.  Handy when using curl.

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('example#welcome');
}

1;
