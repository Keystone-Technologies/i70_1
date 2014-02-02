package I70::EMR::D::Vitals;
use Mojo::Base 'I70::EMR::D';

sub rest_list { shift->SUPER::rest_list('SELECT * FROM emrd_vitals vitals') }

1;

__DATA__
@@ vitals/index.html.ep
% layout 'pqgrid', url => "/emr_d/vital";
% title 'Vitals';
% content_for 'colM' => begin
  { title: "ID", width: 190 },
  { title: "SSN", width: 160 },
  { title: "Height", width: 190 }
% end