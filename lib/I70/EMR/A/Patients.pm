package I70::EMR::A::Patients;
use Mojo::Base 'I70::EMR::A';

has colM => sub {[
  {title=>'ID', width=>190, dataIndx=>'id'},
  {title=>'Name', width=>160, dataIndx=>'name'},
  {title=>'SSN', width=>190, dataIndx=>'ssn'},
  {title=>'DoB', width=>160, dataIndx=>'dob'},
  {title=>'Nationality', width=>160, dataIndx=>'nationality'},
]};

sub rest_list { shift->SUPER::rest_list('emra_patients') }

sub rest_create { shift->SUPER::rest_create('emra_patients') }
  
sub rest_remove { shift->SUPER::rest_remove('emra_patients', 'patientsid') }

sub rest_update { shift->SUPER::rest_update('emra_patients', 'patientsid') }
 
1;

__DATA__
@@ patients/index.html.ep
% layout 'pqgrid', url => "/emr_a/patient";
% title 'Patients';
% content_for 'colM' => <%== j $self->colM =%>;
