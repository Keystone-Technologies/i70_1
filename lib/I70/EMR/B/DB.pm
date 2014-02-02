package I70::EMR::B::DB;
use Mojo::Base "I70::EMR::DB";

sub sync {
  shift->SUPER::sync(
    q{SELECT weight,nationality,md5(concat(patients.ssn, dob)) as deid FROM emrb_patients patients LEFT JOIN emrb_vitals vitals USING (ssn) ORDER BY RAND()},
  );
}

1;
