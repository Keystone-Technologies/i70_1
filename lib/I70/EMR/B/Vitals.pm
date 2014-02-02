package I70::EMR::B::Vitals;
use Mojo::Base 'I70::EMR::B';

sub rest_list { shift->SUPER::rest_list('SELECT * FROM emrb_vitals vitals') }

1;

__DATA__
@@ vitals/index.html.ep
% layout 'pqgrid', url => "/emr_b/vital";
% title 'Vitals';
% content_for 'colM' => begin
  { title: "ID", width: 190 },
  { title: "SSN", width: 160 },
  { title: "Height", width: 190 }
% end
