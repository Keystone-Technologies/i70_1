package I70::EMR::D::Patients;
use Mojo::Base 'I70::EMR::D';

has table => 'emrd_patients';
has url => '/emr_d/patient';
has key => 'patientsid';
has colM => sub {[
  {title=>'ID', width=>190, dataIndx=>'id'},
  {title=>'Name', width=>160, dataIndx=>'name'},
  {title=>'SSN', width=>190, dataIndx=>'ssn'},
  {title=>'DoB', width=>160, dataIndx=>'dob'},
  {title=>'Ethnicity', width=>160, dataIndx=>'ethnicity'},
  {title=>'Household Income', width=>160, dataIndx=>'household_income'},
]};

1;

__DATA__
@@ patients/index.html.ep
% layout 'pqgrid';
% title 'Patients';
