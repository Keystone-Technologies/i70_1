package I70::EMR::D::DB;
use Mojo::Base "I70::EMR::DB";

sub sync {
  shift->SUPER::sync(
    q{SELECT weight,ethnicity,md5(concat(patients.ssn, dob)) as deid FROM emrd_patients patients LEFT JOIN emrd_vitals vitals USING (ssn) ORDER BY RAND()},
    q{SELECT ethnicity,household_income,md5(concat(patients.ssn, dob)) as deid FROM emrd_patients patients ORDER BY RAND()},
  );
}

1;
