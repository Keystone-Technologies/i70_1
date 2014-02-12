package I70::EMR::C::Vitals;
use Mojo::Base 'I70::EMR::C';

has table => 'emrc_vitals';
has url => '/emr_c/vital';
has key => 'vitalsid';
has colM => sub {[
  {title=>'ID', width=>190, dataIndx=>'id'},
  {title=>'SSN', width=>190, dataIndx=>'ssn'},
  {title=>'Height', width=>160, dataIndx=>'height'},
]};

1;

__DATA__
@@ vitals/index.html.ep
% layout 'pqgrid';
% title 'Vitals';
