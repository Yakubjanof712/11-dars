CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE news (
    id SERIAL PRIMARY KEY,
    category_id INTEGER REFERENCES categories(id),
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    published_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_published BOOLEAN DEFAULT FALSE
);

CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    news_id INTEGER REFERENCES news(id),
    author_name VARCHAR(100),
    comment_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE news ADD COLUMN views INTEGER DEFAULT 0;

ALTER TABLE comments ALTER COLUMN author_name TYPE TEXT;

INSERT INTO categories (name, description)
VALUES
    ('Technologiya', 'Yangilikni organ'),
    ('Sportlar', 'Soglom bol'),
    ('Soglik', 'Sogliq birinchi orinda');

INSERT INTO news (category_id, title, content)
VALUES
    (1, 'Yangilikni organish', 'texnologiya baribir zor'),
    (2, 'Sportlar', 'BugunGi kunda Sport eng yahshi mashgulot'),
    (3, 'Soglomlik masulyati', 'Soglom bolishi kerak');

INSERT INTO comments (news_id, author_name, comment_text)
VALUES
    (1, 'Sherxon', 'Judayam qiziq texnalogiya'),
    (2, 'Azamjon', 'Sport judayam qiziqarli'),
    (3, 'Zafar', 'Judayam foydali malumot');

UPDATE news
SET is_published = TRUE
WHERE published_at < NOW() - INTERVAL '5 days';

DELETE FROM comments
WHERE created_at < NOW() - INTERVAL '1 year';
SELECT name, COUNT(id) AS news_count
FROM categories
LEFT JOIN news ON categories id = news category_id
GROUP BY name
    
SELECT * FROM news
WHERE category_id = (SELECT id FROM categories WHERE name = 'Technologiya');

SELECT * FROM news
WHERE is_published = TRUE
ORDER BY published_at DESC
LIMIT 1;

SELECT * FROM news
WHERE views BETWEEN 10 AND 100;

SELECT * FROM comments
WHERE author_name LIKE 'A%';

SELECT * FROM comments
WHERE author_name IS NULL;


ALTER TABLE news ADD CONSTRAINT unique_title UNIQUE (title);
