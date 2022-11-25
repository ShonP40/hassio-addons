#!/bin/bash

# Configure the environment
CONFIG_PATH=/data/options.json

export REGION=$(jq --raw-output ".region" $CONFIG_PATH)
export INCLUDE_TEST_ALERTS=$(jq --raw-output ".include_test_alerts" $CONFIG_PATH)
export MQTT_HOST=$(jq --raw-output ".mqtt_host" $CONFIG_PATH)
export MQTT_PORT=$(jq --raw-output ".mqtt_port" $CONFIG_PATH)
export MQTT_USER=$(jq --raw-output ".mqtt_user" $CONFIG_PATH)
export MQTT_PASS=$(jq --raw-output ".mqtt_pass" $CONFIG_PATH)
export MQTT_TOPIC=$(jq --raw-output ".mqtt_topic" $CONFIG_PATH)

# Start the main process
/usr/bin/python3 /opt/redalert/redalert.py