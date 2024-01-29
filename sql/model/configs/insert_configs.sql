INSERT INTO configs (title)
-- title VARCHAR  
VALUES(@title)
RETURNING id;