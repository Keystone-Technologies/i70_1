package I70::EMR::C;
use Mojo::Base 'I70::EMR';

has db => sub { shift->emr_c };

1;
