
CREATE DATABASE conservation_db;

CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY UNIQUE,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL
);

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY UNIQUE,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(100) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50)
    CHECK (conservation_status IN ('Endangered', 'Vulnerable'))
);
CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY UNIQUE,
    species_id INT NOT NULL,
    ranger_id INT NOT NULL,
    sighting_time TIMESTAMP NOT NULL,
    location VARCHAR(100) NOT NULL,
    notes VARCHAR(100) DEFAULT NULL,
    FOREIGN KEY (species_id) REFERENCES species(species_id),
    FOREIGN KEY (ranger_id) REFERENCES rangers(ranger_id)
);

INSERT INTO rangers (name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta '),
('Carol King', 'Mountain Range');


INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1869-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Vulnerable');

INSERT INTO sightings (species_id, ranger_id, sighting_time, location, notes) VALUES
(1, 1, '2023-10-01 08:30:00', 'Peak Ridge', 'Camera trap image captured'),
(2, 2, '2023-10-02 09:00:00', ' Bankwood Area', 'Juvenile seen'),
(3, 3, '2023-10-03 10:15:00', 'Bamboo Grove East', 'Feedings observed'),
(1, 2, '2023-10-04 11:45:00', 'Western Ghats', 'Group of elephants spotted');


-- #1
INSERT INTO rangers (name, region) VALUES
('Derek Fox', 'Coastal Plains');

-- #2
SELECT COUNT(DISTINCT species_id) AS unique_species_count FROM sightings;

-- #3
SELECT * from sightings WHERE location LIKE '%Pass%';

-- #4
SELECT r.name AS "name", COUNT(s.ranger_id) AS "total_sightings"
FROM rangers r
JOIN sightings s ON r.ranger_id = s.ranger_id
GROUP BY r.ranger_id
ORDER BY "name" ASC;


-- #5
SELECT common_name FROM species 
LEFT JOIN sightings ON species.species_id = sightings.species_id 
WHERE sightings.species_id IS NULL;


-- #6
SELECT common_name, sighting_time, name FROM species
LEFT JOIN sightings ON species.species_id = sightings.species_id
JOIN rangers ON sightings.ranger_id = rangers.ranger_id
ORDER BY sighting_time DESC
LIMIT 2;

-- #7
UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date <= '1800-01-01';

-- #8

SELECT
  sighting_id,
  CASE
    WHEN sighting_time::time < TIME '12:00:00' THEN 'Morning'
    WHEN sighting_time::time >= TIME '12:00:00' AND sighting_time::time < TIME '17:00:00' THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_of_day
FROM sightings;

-- #9
DELETE FROM rangers r
WHERE NOT EXISTS (
  SELECT * FROM sightings s WHERE s.ranger_id = r.ranger_id
);