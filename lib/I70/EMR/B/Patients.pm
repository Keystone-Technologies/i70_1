package I70::EMR::B::Patients;
use Mojo::Base 'I70::EMR::B';

has table => 'emrb_patients';
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
% layout 'pqgrid', url => "/emr_b/patient";
% title 'Patients';
