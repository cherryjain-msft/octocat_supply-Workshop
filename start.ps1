#!/usr/bin/env pwsh
# PowerShell script to start the OctoCAT Supply Chain application

Write-Host "====================================" -ForegroundColor Cyan
Write-Host "Starting OctoCAT Supply Chain App" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

# Check if Make is available
$makeExists = Get-Command make -ErrorAction SilentlyContinue

if ($makeExists) {
    Write-Host "Using Make..." -ForegroundColor Green
    make dev
} else {
    Write-Host "Make not found. Starting manually..." -ForegroundColor Yellow
    Write-Host ""
    
    # Install dependencies if needed
    Write-Host "Checking dependencies..." -ForegroundColor Green
    if (-not (Test-Path ".\api\node_modules")) {
        Write-Host "Installing API dependencies..." -ForegroundColor Yellow
        Push-Location api
        npm install
        Pop-Location
    }
    
    if (-not (Test-Path ".\frontend\node_modules")) {
        Write-Host "Installing Frontend dependencies..." -ForegroundColor Yellow
        Push-Location frontend
        npm install
        Pop-Location
    }
    
    Write-Host ""
    Write-Host "Starting servers in separate windows..." -ForegroundColor Green
    
    # Start API server in new window
    Start-Process pwsh -ArgumentList "-NoExit", "-Command", "cd api; npm run dev" -WorkingDirectory $PSScriptRoot
    
    Write-Host "API server window opened..." -ForegroundColor Yellow
    Start-Sleep -Seconds 2
    
    # Start Frontend server in new window
    Start-Process pwsh -ArgumentList "-NoExit", "-Command", "cd frontend; npm run dev" -WorkingDirectory $PSScriptRoot
    
    Write-Host "Frontend server window opened..." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "====================================" -ForegroundColor Cyan
    Write-Host "Servers are starting!" -ForegroundColor Green
    Write-Host "API: http://localhost:3000" -ForegroundColor White
    Write-Host "Frontend: http://localhost:5137" -ForegroundColor White
    Write-Host "====================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Close the server windows to stop them." -ForegroundColor Yellow
}
