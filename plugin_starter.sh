#!/bin/bash

set -e

function error() {
    echo "Error: $1"
    exit -1
}

PLUGIN_NAME=$1

function execute {
    local plugin="${PLUGIN_NAME}_plugin"
    local PluginName="$(tr '[:lower:]' '[:upper:]' <<< ${PLUGIN_NAME:0:1})${PLUGIN_NAME:1}"
    if [ -d "$plugin" ]; then
      error "Folder already exists: $plugin"
    fi
    echo $'\n[== Creating new Airflow Plugin ==]'
    echo "Plugin Name -- ${PluginName}Plugin"
    echo "Creating in folder -- $plugin"
    mkdir -p ${plugin}/hooks && echo "" > ${plugin}/hooks/__init__.py
    mkdir -p ${plugin}/operators && echo "" > ${plugin}/operators/__init__.py
    echo "from airflow.plugins_manager import AirflowPlugin

from ${plugin}.hooks.${PLUGIN_NAME}_hook import ${PluginName}Hook
from ${plugin}.operators.${PLUGIN_NAME}_starter_operator import ${PluginName}StarterOperator


class ${PluginName}Plugin(AirflowPlugin):
    name = \"${plugin}\"
    operators = [${PluginName}StarterOperator]
    hooks = [${PluginName}Hook]

" > ${plugin}/__init__.py

    # setup.py
    echo "from setuptools import setup

setup(
    name=\"${PLUGIN_NAME}-plugin\",
    entry_points = { 'airflow.plugins': ['${plugin} = ${PLUGIN_NAME}-plugin.${plugin}:${PluginName}Plugin'] }
)

" > ${plugin}/setup.py

    # Hook
    echo "from airflow.hooks.http_hook import HttpHook
    
class ${PluginName}Hook(HttpHook):
  def __init__(self, ${PLUGIN_NAME}_conn_id=\"${PLUGIN_NAME}_default\"):
      super().__init__(http_conn_id=${PLUGIN_NAME}_conn_id)

  def get_conn(self, headers):
      return super().get_conn(headers)

" > ${plugin}/hooks/${PLUGIN_NAME}_hook.py

  # Operator
  echo "import logging
  
from airflow.utils.decorators import apply_defaults
from airflow.models import BaseOperator
  
from ${plugin}.hooks.${PLUGIN_NAME}_hook import ${PluginName}Hook

class ${PluginName}StarterOperator(BaseOperator):
    \"\"\"
    ${PluginName} Starter Operator

    Description about ${PluginName} Starter Operator

    :param ${PLUGIN_NAME}_conn_id:              The ${PLUGIN_NAME} connection id.
    :type ${PLUGIN_NAME}_conn_id:              string
    :param required_param:              Required parameter description.
    :type required_param:               string
    :param optional_param:              *optional* Optional parameter description.
    :type optional_param:               string
    :param optional_payload:            *optional* Optional payload parameter description.
    :type optional_payload:             dict
    \"\"\"

    template_fields = ('required_param',)
    ui_color = '#133a78'
    ui_fgcolor = '#ffffff'

    @apply_defaults
    def __init__(self,
                  ${PLUGIN_NAME}_conn_id,
                  required_param,
                  optional_param=None,
                  optional_payload={},
                  **kwargs):
        super().__init__(**kwargs)
        self.${PLUGIN_NAME}_conn_id = ${PLUGIN_NAME}_conn_id
        self.required_param = required_param
        self.optional_param = optional_param
        self.optional_payload = optional_payload

    def execute(self, context):
        self.${PLUGIN_NAME}_hook = ${PluginName}Hook(self.${PLUGIN_NAME}_conn_id)
        output = []
        # Do some work on output
        # i.e. imagine ${PluginName}Hook contains method do_work() which takes input required_param
        # self.output = ${PLUGIN_NAME}_hook.do_work(self.required_param)
        return self.output
  
  " > ${plugin}/operators/${PLUGIN_NAME}_starter_operator.py

  # Optional 
  # Uncomment line below to initialize plugin with virtualenv, python3, activate and install linter, formatter and airflow
  # cd ${plugin} && virtualenv --python python3 env && source env/bin/activate && pip install pylint black apache-airflow
  # Uncomment line below to subsequently open plugin project with code editor once initialized. code, pycharm, subl etc
  # code ${plugin}
}

execute
