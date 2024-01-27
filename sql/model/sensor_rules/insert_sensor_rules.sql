INSERT INTO sensorrules (type, value)
VALUES (@type, @value)
RETURNING id;