SELECT 
  IIF(CASE CASE 1
  WHEN 1 THEN
    10
  WHEN 2 THEN
    20
  ELSE
    30
  END
  WHEN 1 THEN
    10
  WHEN 2 THEN
    20
  ELSE
    30
  END = 10, 1, 0) 
FROM 
  RDB$DATABASE