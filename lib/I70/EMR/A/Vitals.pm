package I70::EMR::A::Vitals;
use Mojo::Base 'I70::EMR::A';

has table => 'emra_vitals';
has key => 'vitalsid';
has colM => sub {[
  {title=>'ID', width=>190, dataIndx=>'id'},
  {title=>'SSN', width=>190, dataIndx=>'ssn'},
  {title=>'Weight', width=>160, dataIndx=>'weight'},
]};

1;

__DATA__
@@ vitals/index.html.ep
% layout 'pqgrid', url => "/emr_a/vital";
% title 'Vitals';
