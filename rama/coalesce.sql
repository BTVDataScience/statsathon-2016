alter table testData add p float;

update testData set p = coalesce(p_14, p_13, p_12, p_11, p_10, p_9, p_8, p_7, p_6, p_5, p_4, p_3, p_2, p_1);
