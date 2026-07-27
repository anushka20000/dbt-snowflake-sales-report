param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Args
)

$repoRoot = Split-Path -Parent $PSScriptRoot
$envFile = Join-Path $repoRoot '.env'

if (Test-Path $envFile) {
    Get-Content $envFile | ForEach-Object {
        if ([string]::IsNullOrWhiteSpace($_) -or $_.TrimStart().StartsWith('#')) {
            return
        }

        $parts = $_ -split '=', 2
        if ($parts.Count -eq 2) {
            $name = $parts[0].Trim()
            $value = $parts[1].Trim()
            if ($name -and -not [string]::IsNullOrWhiteSpace($value)) {
                [Environment]::SetEnvironmentVariable($name, $value, 'Process')
            }
        }
    }
}

if (-not $env:DATABRICKS_TOKEN) {
    Write-Error "DATABRICKS_TOKEN is not set. Create a .env file in the repo root with DATABRICKS_TOKEN=your_token_here and rerun this script."
    exit 1
}

Push-Location (Join-Path $repoRoot 'dbt_project')
try {
    & (Join-Path $repoRoot '.venv/Scripts/dbt.exe') @Args
}
finally {
    Pop-Location
}
