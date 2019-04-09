# Airflow Plugin Starter

Bash script which take a single-word input and scaffolds an Apache Airflow Plugin project including `setup.py` file per [Airflow Docs >> Plugins >> Plugins as Python packages](https://airflow.apache.org/plugins.html#plugins-as-python-packages).

## Instructions

1. Clone or download this repo

    ```
    $ git clone https://source.developers.google.com/p/ffn-marketing-prd/r/github_jamesnsimo_airflow-plugin-starter
    ```

    ```
    $ gcloud source repos clone github_jamesnsimo_airflow-plugin-starter --project=ffn-marketing-prd
    ```

    Alternatively download contents of `plugin_starter.sh` here

    ```
    https://storage.cloud.google.com/cloud-repositories-ffn-marketing-prd/airflow-plugin-starter/plugin_starter.sh
    ```

1. cd into directory

    ```
    $ cd airflow-plugin-starter
    ```

1. Make script executable

    ```
    $ chmod u+x plugin_starter.sh
    ```

1. Create plugin (in the following example replace `[webapp]` with __lowercased single-word__ app name such as `confluence`)

    ```
    $ ./plugin_starter.sh [webapp]
    ```

## Example

The following example uses input `confluence`

```
$ ./plugin_starter.sh confluence
```

Creates plugin structure like below

```
.
└── confluence_plugin
    ├── __init__.py
    ├── hooks
    │   ├── __init__.py
    │   └── confluence_hook.py
    ├── operators
    │   ├── __init__.py
    │   └── confluence_starter_operator.py
    └── setup.py
```

## Optional

Uncomment line towards bottom of `plugin_starter.sh` starting with `cd ${plugin} ...` to immediately initialize virtualenv (with python3), install pylint, black code formatter and airflow in plugin.

## Next Steps

Use the output folder/files/file structure as general guidelines for creating a new plugin. You will want to rename the operator and operator file, rewrite the import paths once renamed, write the actual operator code, write the hook logic etc. Many useful plugin examples can be found under [Airflow Plugins](https://github.com/airflow-plugins) link found at top of [Resources](#Resources) section below.

## Resources

[Airflow Plugins](https://github.com/airflow-plugins)
> Hooks, Operators, and Utilities for Apache Airflow, maintained with ❤️ by Astronomer, Inc.

[Airflow Docs >> Plugins](https://airflow.apache.org/plugins.html)

[Python in Visual Studio Code](https://code.visualstudio.com/docs/languages/python)

