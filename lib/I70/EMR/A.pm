package I70::EMR::A;
use Mojo::Base 'I70::EMR';

has db => sub { shift->emr_a };

1;
