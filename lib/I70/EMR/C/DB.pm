package I70::EMR::C::DB;
use Mojo::Base "I70::EMR::DB";

sub sync {
  shift->SUPER::sync(
    q{SELECT height,ethnicity,md5(concat(patients.ssn, dob)) as deid FROM emrc_patients patients LEFT JOIN emrc_vitals vitals USING (ssn) ORDER BY RAND()},
  );
}

1;
