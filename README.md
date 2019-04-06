# Airflow Plugin Starter

Bash script which take a single word input and scaffolds an Apache Airflow Plugin folder including `setup.py` file per [Airflow docs](https://airflow.apache.org/plugins.html#plugins-as-python-packages).

The following example takes input `ibm`.

```
$ ./plugin_starter.sh ibm
```

Creates plugin structure like below

```
├── __init__.py
├── hooks
│   ├── __init__.py
│   └── ibm_hook.py
├── operators
│   ├── __init__.py
│   └── ibm_starter_operator.py
└── setup.py
```