UPDATE graphs 
-- type         Enum graphtype
-- dependency   Enum graphdependency
SET	type = @type,
	dependency = @dependency
-- id uuid
WHERE id = @id;	