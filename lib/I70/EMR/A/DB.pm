package I70::EMR::A::DB;
use Mojo::Base "I70::EMR::DB";

sub sync {
  shift->SUPER::sync(
    q{SELECT height,nationality,md5(concat(patients.ssn, dob)) as deid FROM emra_patients patients LEFT JOIN emra_vitals vitals USING (ssn) ORDER BY RAND()},
  );
}

1;
