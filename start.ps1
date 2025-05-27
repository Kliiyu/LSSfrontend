$frontendPath = Split-Path -Parent $MyInvocation.MyCommand.Path

if ((Get-Item $frontendPath).Name -eq 'LSSfrontend') {
    Write-Host "Starting LSS frontend development server..."
} else {
    Write-Host "Current directory is not LSSfrontend. Script may not work as expected."
}

try {
    Write-Host "Running npm run dev..."
    npm run dev -- --host
} catch {
    Write-Host "Error running npm run dev. Make sure Node.js and npm are installed."
    Write-Host "Error details: $_"
    exit 1
}
