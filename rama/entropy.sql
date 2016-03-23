drop function if exists entropy;

create function entropy(p float) returns float deterministic return (-p * log(p) - (1-p) * log(1-p)) / log(2);
