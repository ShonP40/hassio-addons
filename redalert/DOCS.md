# Red Alert (forked from [t0mer](https://github.com/t0mer))

Get redalerts for your area from [Oref's website](https://www.oref.org.il)

## Addon configuration

- *MQTT_HOST*</br>
Used for setting the MQTT Broker address, default value is `127.0.0.1`.
- *MQTT_PORT*</br>
Used for setting the MQTT Broker Port, default value is `1883`.
- *MQTT_USER*</br>
Used for setting the MQTT Broker Username, default value is `user`.
- *MQTT_PASS*</br>
Used for setting the MQTT Broker Password, default value is `password`.
- *MQTT_TOPIC*</br>
Custom MQTT Topic. default value is `redalert`
- *INCLUDE_TEST_ALERTS*</br>
used to show pikud ha oref tests, default is False.
- *REGION*</br>
Used for setting the region for monitoring. default is * (any)

## Usage

### Adding Sensor in Home-Assistant
#### Get full json (including date and id)
```yaml
  - platform: mqtt
    name: "Red Alert"
    state_topic: "redalert/"
    # unit_of_measurement: '%'
    icon: fas:broadcast-tower
    value_template: "{{ value_json }}"
    qos: 1
```

#### Get json with alert areas only
```yaml
  - platform: mqtt
    name: "Red Alert"
    state_topic: "redalert/"
    # unit_of_measurement: '%'
    icon: fas:broadcast-tower
    value_template: "{{ value_json.data }}"
    qos: 1
```

#### Alaram state (Value will be on/off)
```yaml
  - platform: mqtt
    name: "Red Alert"
    state_topic: "redalert/alarm"
    icon: fas:broadcast-tower
    value_template: "{{ value_json }}"
    qos: 1
```