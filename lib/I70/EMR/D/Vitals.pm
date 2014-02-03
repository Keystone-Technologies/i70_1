package I70::EMR::D::Vitals;
use Mojo::Base 'I70::EMR::D';

has table => 'emrd_vitals';
has key => 'vitalsid';
has colM => sub {[
  {title=>'ID', width=>190, dataIndx=>'id'},
  {title=>'SSN', width=>190, dataIndx=>'ssn'},
  {title=>'Height', width=>160, dataIndx=>'height'},
]};

1;

__DATA__
@@ vitals/index.html.ep
% layout 'pqgrid', url => "/emr_d/vital";
% title 'Vitals';
