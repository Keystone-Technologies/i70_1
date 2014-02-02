package I70::EMR::B;
use Mojo::Base 'I70::EMR';

has db => sub { shift->emr_b };

1;
