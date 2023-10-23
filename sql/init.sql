CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TYPE public.graphtype AS ENUM
    ('linear', 'columnar', 'spot');

ALTER TYPE public.graphtype
    OWNER TO postgres;
	
CREATE TYPE public.graphdependency AS ENUM
    ('average', 'minimal', 'maximum', 'addiction', 'scatterPlot', 'sensors');

ALTER TYPE public.graphdependency
    OWNER TO postgres;
	
CREATE TABLE IF NOT EXISTS Configs (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    title VARCHAR UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS Tabs (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    config_id UUID,
    FOREIGN KEY(config_id) REFERENCES Configs (id),
    title VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS Sensors (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    config_id UUID,
    FOREIGN KEY(config_id) REFERENCES Configs (id),
    title VARCHAR UNIQUE NOT NULL
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
    FOREIGN KEY(graphs_id) REFERENCES Graphs (id),
    FOREIGN KEY(sensor_id) REFERENCES Sensors (id)
);

CREATE TABLE IF NOT EXISTS TabSensors(
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    sensor_id UUID,
    tab_id UUID,
    FOREIGN KEY(sensor_id) REFERENCES Sensors (id),
    FOREIGN KEY(tab_id) REFERENCES Tabs (id)
);

CREATE TABLE IF NOT EXISTS Rules(
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    description VARCHAR UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS SensorRules(
    sensor_id UUID,
    rule_id UUID,
    FOREIGN KEY(sensor_id) REFERENCES Sensors (id),
    FOREIGN KEY(rule_id) REFERENCES Rules (id),
    value real NOT NULL
);

CREATE TABLE IF NOT EXISTS SensorsHistory(
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    sensor_id UUID,
    FOREIGN KEY(sensor_id) REFERENCES Sensors (id),
    date timestamp NOT NULL,
    value real NOT NULL
);

CREATE TABLE IF NOT EXISTS Alerts(
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    sensor_id UUID,
    rule_id UUID,
    FOREIGN KEY(sensor_id) REFERENCES Sensors (id),
    FOREIGN KEY(rule_id) REFERENCES Rules (id),
    message VARCHAR
);
