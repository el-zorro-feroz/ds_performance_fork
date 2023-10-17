CREATE TABLE IF NOT EXISTS Configs (
    id UUID PRIMARY KEY,
    title VARCHAR UNIQUE NOT NULL
)

CREATE TABLE IF NOT EXISTS Tabs (
    id UUID PRIMARY KEY,
    config_id UUID,
    FOREIGN KEY(config_id) REFERENCES Configs (id),
    title VARCHAR NOT NULL
)

CREATE TABLE IF NOT EXISTS Sensors (
    id UUID PRIMARY KEY,
    config_id UUID,
    FOREIGN KEY(config_id) REFERENCES Configs (id),
    config_id VARCHAR UNIQUE NOT NULL
)

CREATE TABLE IF NOT EXISTS Graphs (
    id UUID PRIMARY KEY, 
    type GraphType NOT NULL,
    dependency GraphDependency NOT NULL
)

CREATE TABLE IF NOT EXISTS GraphSensors(
    id UUID PRIMARY KEY,
    graphs_id UUID,
    sensor_id UUID,
    FOREIGN KEY(graphs_id) REFERENCES Graphs (id),
    FOREIGN KEY(sensor_id) REFERENCES Sensors (id)
)

CREATE TABLE IF NOT EXISTS TabSensors(
    id UUID PRIMARY KEY,
    sensor_id UUID,
    tab_id UUID,
    FOREIGN KEY(sensor_id) REFERENCES Sensors (id),
    FOREIGN KEY(tab_id) REFERENCES Tabs (id)
)

CREATE TABLE IF NOT EXISTS Rules(
    id UUID PRIMARY KEY,
    description VARCHAR NOT NULL
)

CREATE TABLE IF NOT EXISTS SensorRules(
    sensor_id UUID,
    rule_id UUID,
    FOREIGN KEY(sensor_id) REFERENCES Sensors (id),
    FOREIGN KEY(rule_id) REFERENCES Sensors (id),
    value real NOT NULL
)

CREATE TABLE IF NOT EXISTS SensorsHistory(
    id UUID PRIMARY KEY,
    sensor_id UUID,
    FOREIGN KEY(sensor_id) REFERENCES Sensors (id),
    date timestamp NOT NULL,
    value real NOT NULL,

)

CREATE TABLE IF NOT EXISTS Alerts(
    id UUID PRIMARY KEY,
    sensor_id UUID,
    rule_id UUID,
    FOREIGN KEY(sensor_id) REFERENCES Sensors (id),
    FOREIGN KEY(rule_id) REFERENCES Rules (id),
)