package I70::EMR::C::Vitals;
use Mojo::Base 'I70::EMR::C';

has table => 'emrc_vitals';
has key => 'vitalsid';
has colM => sub {[
  {title=>'ID', width=>190, dataIndx=>'id'},
  {title=>'SSN', width=>190, dataIndx=>'ssn'},
  {title=>'Weight', width=>160, dataIndx=>'weight'},
]};

1;

__DATA__
@@ vitals/index.html.ep
% layout 'pqgrid', url => "/emr_c/vital";
% title 'Vitals';
