package I70::EMR::C::Patients;
use Mojo::Base 'I70::EMR::C';

has table => 'emrc_patients';
has url => '/emr_c/patient';
has key => 'patientsid';
has colM => sub {[
  {title=>'ID', width=>190, dataIndx=>'id'},
  {title=>'Name', width=>160, dataIndx=>'name'},
  {title=>'SSN', width=>190, dataIndx=>'ssn'},
  {title=>'DoB', width=>160, dataIndx=>'dob'},
  {title=>'Ethnicity', width=>160, dataIndx=>'ethnicity'},
]};

1;

__DATA__
@@ patients/index.html.ep
% layout 'pqgrid';
% title 'Patients';
