package I70;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  $self->plugin('PQGridCrud');
  $self->plugin('RESTRoutes');
  $self->plugin('I70::Plugin::EMR');
  $self->app->hook(after_render => sub { ${$_[1]} .= "\n" }); # Append \n to all rendered output.  Handy when using curl.
  $self->app->helper(j => sub { shift; Mojo::JSON::j(@_) });
  $self->app->hook(before_render => sub {
    my ($self, $args) = @_;
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

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('example#welcome');
}

1;
