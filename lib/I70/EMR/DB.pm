package I70::EMR::DB;
use Mojo::Base -base;

use Mojo::Log;

use DBIx::Connector;

has log => sub { Mojo::Log->new };

sub new {
  my $self = shift->SUPER::new(@_);
  $self->log->info(sprintf "Connecting to %s", ref $self);
  DBIx::Connector->new('dbi:mysql:sql228584;host=sql2.freemysqlhosting.net', 'sql228584', 'rF5*eP5%', {
      RaiseError => 1,
      AutoCommit => 1,
  });
};

1;
