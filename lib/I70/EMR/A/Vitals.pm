package I70::EMR::A::Vitals;
use Mojo::Base 'I70::EMR::A';

sub rest_list { shift->SUPER::rest_list('SELECT * FROM emra_vitals vitals') }

1;

__DATA__
@@ vitals/index.html.ep
% layout 'pqgrid', url => "/emr_a/vital";
% title 'Vitals';
% content_for 'colM' => begin
  { title: "ID", width: 190 },
  { title: "SSN", width: 160 },
  { title: "Weight", width: 190 }
% end
