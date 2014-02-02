package I70::EMR::C::Vitals;
use Mojo::Base 'I70::EMR::C';

sub rest_list { shift->SUPER::rest_list('SELECT * FROM emrc_vitals vitals') }

1;

__DATA__
@@ vitals/index.html.ep
% layout 'pqgrid', url => "/emr_c/vital";
% title 'Vitals';
% content_for 'colM' => begin
  { title: "ID", width: 190 },
  { title: "SSN", width: 160 },
  { title: "Height", width: 190 }
% end
