package I70::EMR::D;
use Mojo::Base 'I70::EMR';

has db => sub { shift->emr_d };

1;
