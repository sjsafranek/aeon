

DROP TABLE IF EXISTS datasources CASCADE;

-- @table users
-- @description stores users for find system
CREATE TABLE IF NOT EXISTS datasources (
    _id             VARCHAR NOT NULL DEFAULT md5(random()::text),
    id              VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
    name            VARCHAR(25),
    description     VARCHAR(50),
    is_active       BOOLEAN DEFAULT TRUE,
    is_deleted      BOOLEAN DEFAULT FALSE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE datasources IS 'Datasoures';

-- @trigger users_update
DROP TRIGGER IF EXISTS datasources_update ON datasources;
CREATE TRIGGER datasources_update
    BEFORE UPDATE ON datasources
        FOR EACH ROW
            EXECUTE PROCEDURE update_modified_column();




DROP FUNCTION create_datasource(text);

-- @function create_datasource
-- @description Create datasource
CREATE OR REPLACE FUNCTION create_datasource(ds_name TEXT)
    RETURNS TABLE (datasource JSON) AS
$BODY$
BEGIN
    RETURN QUERY INSERT INTO datasources(name) VALUES (ds_name) RETURNING json_build_object(
        'id', datasources.id,
        'name', datasources.name,
        'description', datasources.description,
        'is_active', datasources.is_active,
        'is_deleted', datasources.is_deleted,
        'created_at', to_char(datasources.created_at, 'YYYY-MM-DD"T"HH:MI:SS"Z"'),
        'updated_at', to_char(datasources.updated_at, 'YYYY-MM-DD"T"HH:MI:SS"Z"')
    );
END;
$BODY$
LANGUAGE 'plpgsql';





SELECT create_datasource('test');



DROP TABLE static__d65363b927596259933663a03741a181 CASCADE;
CREATE TABLE static__d65363b927596259933663a03741a181 (
    id VARCHAR NOT NULL PRIMARY KEY
);

DROP TABLE time_series__d65363b927596259933663a03741a181 CASCADE;
CREATE TABLE time_series__d65363b927596259933663a03741a181 (
    id VARCHAR NOT NULL,
    -- event_timestamp INTEGER,
    event_timestamp TIMESTAMPTZ,
    geom geometry(POINT, 4326),
    CONSTRAINT event PRIMARY KEY(id, event_timestamp),
    FOREIGN KEY (id) REFERENCES static__d65363b927596259933663a03741a181(id) ON DELETE CASCADE
);

-- SELECT AddGeometryColumn ('locations', 'geom', 4326, 'POINT', 2);
CREATE INDEX time_series__d65363b927596259933663a03741a181__gidx ON time_series__d65363b927596259933663a03741a181 USING GIST(geom);


SELECT create_hypertable('time_series__d65363b927596259933663a03741a181', 'event_timestamp', chunk_time_interval => INTERVAL '1 day');














SELECT create_hypertable('time_series__d65363b927596259933663a03741a181', 'event_timestamp', 'geom', 4);

SELECT create_hypertable('time_series__d65363b927596259933663a03741a181', 'event_timestamp', 'geom', 4, chunk_time_interval => 86400);




--
--
-- CREATE TYPE geo_event AS (event_timestamp INTEGER, geom geometry(POINT, 4326));
--
-- CREATE FUNCTION geohash(geo_event)
--   RETURNS TEXT
--   LANGUAGE SQL
--   IMMUTABLE AS
--   'SELECT ST_GeoHash($1.geom, 6)';
--
--
--
-- SELECT create_hypertable('time_series__d65363b927596259933663a03741a181', 'event_timestamp', 'geom', 4, chunk_time_interval => 86400, partitioning_func => 'geohash');
--











---
