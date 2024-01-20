CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TYPE public.graphtype AS ENUM
    ('curve', 'columnar', 'sensors');

ALTER TYPE public.graphtype
    OWNER TO postgres;
	
CREATE TYPE public.graphdependency AS ENUM
    ('average', 'minimal', 'maximum', 'none');

ALTER TYPE public.graphdependency
    OWNER TO postgres;

CREATE TYPE public.sensortype AS ENUM
    ('humidity','temperature');

ALTER TYPE public.sensortype
    OWNER TO postgres;

CREATE TYPE public.alerttype AS ENUM
    ('info','warning','error','fatal');    

ALTER TYPE public.alerttype
    OWNER TO postgres;

CREATE TYPE public.ruletype AS ENUM
    ('min','max','avg');

ALTER TYPE public.ruletype
    OWNER TO postgres;

CREATE TABLE IF NOT EXISTS Configs (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    title VARCHAR UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS Tabs (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    config_id UUID,
    FOREIGN KEY(config_id) REFERENCES Configs (id) ON DELETE CASCADE,
    title VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS Sensors (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    config_id UUID,
    FOREIGN KEY(config_id) REFERENCES Configs (id) ON DELETE CASCADE,
    title VARCHAR UNIQUE NOT NULL,
    type SensorType NOT NULL,
    details VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS Graphs (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY, 
    type GraphType NOT NULL,
    dependency GraphDependency NOT NULL
);

CREATE TABLE IF NOT EXISTS GraphSensors(
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    graphs_id UUID,
    sensor_id UUID,
    FOREIGN KEY(graphs_id) REFERENCES Graphs (id) ON DELETE CASCADE,
    FOREIGN KEY(sensor_id) REFERENCES Sensors (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS TabSensors(
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    sensor_id UUID,
    tab_id UUID,
    FOREIGN KEY(sensor_id) REFERENCES Sensors (id) ON DELETE CASCADE,
    FOREIGN KEY(tab_id) REFERENCES Tabs (id) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS SensorRules(
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    type RuleType NOT NULL,
    value real NOT NULL
);

CREATE TABLE IF NOT EXISTS SensorHistory(
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    sensor_id UUID,
    FOREIGN KEY(sensor_id) REFERENCES Sensors (id) ON DELETE CASCADE,
    date timestamp NOT NULL,
    value real NOT NULL
);

CREATE TABLE IF NOT EXISTS Alerts(
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    sensor_id UUID,
    FOREIGN KEY(sensor_id) REFERENCES Sensors (id) ON DELETE CASCADE,
    type AlertType NOT NULL,
    message VARCHAR,
    title VARCHAR,
    description VARCHAR
);

CREATE TABLE IF NOT EXISTS RuleGroups(
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    alert_id UUID,
    rule_id UUID,
    FOREIGN KEY(alert_id) REFERENCES Alerts (id) ON DELETE CASCADE,
    FOREIGN KEY(rule_id) REFERENCES SensorRules (id) ON DELETE CASCADE
);
