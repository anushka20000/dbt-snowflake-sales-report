# dbt-snowflake-sales-report

## Databricks setup

The dbt profile in [dbt_project/profiles.yml](dbt_project/profiles.yml) reads the Databricks token from the environment variable DATABRICKS_TOKEN.

1. Copy [.env.example](.env.example) to .env and replace the placeholder value with your real Databricks PAT.
2. Run dbt through the repo helper:
   - PowerShell: `powershell -ExecutionPolicy Bypass -File .\scripts\run_dbt.ps1 debug`
   - Or run the project from the venv directly after exporting the variable: `$env:DATABRICKS_TOKEN='your_token_here'`