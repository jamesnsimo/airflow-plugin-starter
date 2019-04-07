# Airflow Plugin Starter

Bash script which take a single-word input and scaffolds an Apache Airflow Plugin project including `setup.py` file per [Airflow Docs >> Plugins >> Plugins as Python packages](https://airflow.apache.org/plugins.html#plugins-as-python-packages).

## Instructions

1. Clone or download this repo
1. cd into directory

    ```
    $ cd airflow-plugin-starter
    ```

1. Make script executable

    ```
    $ cmod u+x plugin_starter.sh
    ```

1. Create Plugin

    ```
    $ ./plugin_starter.sh [webapp]
    ```

## Example

The following example uses input `ibm`

```
$ ./plugin_starter.sh ibm
```

Creates plugin structure like below

```
.
└── ibm_plugin
    ├── __init__.py
    ├── hooks
    │   ├── __init__.py
    │   └── ibm_hook.py
    ├── operators
    │   ├── __init__.py
    │   └── ibm_starter_operator.py
    └── setup.py
```

## Optional

Uncomment line towards bottom of `plugin_starter.sh` starting with `cd ${plugin} ...` to immediately initialize virtualenv (with python3), install pylint, black code formatter and airflow in plugin.

## Resources

[Airflow Docs >> Plugins](https://airflow.apache.org/plugins.html)

[Google Cloud: Setting Up a Python Development Environment](https://cloud.google.com/python/setup)

[Python in Visual Studio Code](https://code.visualstudio.com/docs/languages/python)

