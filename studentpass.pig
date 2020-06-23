--Load student dataset.
students = LOAD 'student' as (name:chararray,rollnum:int);

--Load result datase
results = LOAD 'results' as (rollnum:int, result:chararray);

-- join student and result dataset
joinstudents = JOIN students by rollnum, results by rollnum;

-- Select Name and result field
studentslist = FOREACH joinstudents GENERATE $0,$3;

-- Select only pass students
passstudents = FILTER studentslist by (result == 'pass');

-- Display result on screen
DUMP passstudents;

-- Store result in PassStudents directory
STORE passstudents INTO 'PassStudents' using PigStorage(',');
