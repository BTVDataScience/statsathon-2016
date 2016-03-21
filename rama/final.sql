drop table if exists testResults;

create table testResults as select INC_KEY, p, rand() <= p as died from testData;
