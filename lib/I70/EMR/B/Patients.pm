package I70::EMR::B::Patients;
use Mojo::Base 'I70::EMR::B';

has table => 'emrb_patients';
has url => '/emr_b/patient';
has key => 'patientsid';
has colM => sub {[
  {title=>'ID', width=>190, dataIndx=>'id'},
  {title=>'Name', width=>160, dataIndx=>'name'},
  {title=>'SSN', width=>190, dataIndx=>'ssn'},
  {title=>'DoB', width=>160, dataIndx=>'dob'},
  {title=>'Nationality', width=>160, dataIndx=>'nationality'},
]};

1;

__DATA__
@@ patients/index.html.ep
% layout 'pqgrid';
% title 'Patients';
