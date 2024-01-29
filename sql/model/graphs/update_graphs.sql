UPDATE graphs 
-- type         Enum graphtype
-- dependency   Enum graphdependency
SET	type = COALESCE (@type, type),
	dependency = COALESCE (@dependency, dependency)
-- id uuid
WHERE id = @id;	