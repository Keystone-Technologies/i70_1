package I70::EMR::A::Patients;
use Mojo::Base 'I70::EMR::A';

has table => 'emra_patients';
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
% layout 'pqgrid', url => "/emr_a/patient";
% title 'Patients';
% content_for 'colM' => <%== j $self->colM =%>;
