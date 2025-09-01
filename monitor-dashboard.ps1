# Claude-Flow Monitoring Dashboard Script
# Real-time monitoring of hive-mind swarms and agents

param(
    [int]$RefreshInterval = 2,
    [switch]$Continuous = $true
)

$Host.UI.RawUI.WindowTitle = "Claude-Flow Monitoring Dashboard"

function Show-Dashboard {
    Clear-Host
    
    Write-Host "=" -ForegroundColor Cyan -NoNewline
    Write-Host " CLAUDE-FLOW MONITORING DASHBOARD " -ForegroundColor White -BackgroundColor DarkBlue -NoNewline
    Write-Host "=" -ForegroundColor Cyan
    Write-Host ""
    
    # Get current timestamp
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "Last Update: $timestamp" -ForegroundColor Gray
    Write-Host ""
    
    # Get hive-mind status
    Write-Host "HIVE-MIND STATUS" -ForegroundColor Yellow
    Write-Host "─" * 60 -ForegroundColor DarkGray
    
    $sessions = & claude-flow hive-mind sessions 2>$null
    if ($sessions) {
        Write-Host $sessions
    }
    
    Write-Host ""
    Write-Host "PERFORMANCE METRICS" -ForegroundColor Yellow
    Write-Host "─" * 60 -ForegroundColor DarkGray
    
    $metrics = & claude-flow hive-mind metrics 2>$null
    if ($metrics) {
        Write-Host $metrics
    }
    
    Write-Host ""
    Write-Host "ACTIVE AGENTS" -ForegroundColor Yellow
    Write-Host "─" * 60 -ForegroundColor DarkGray
    
    $status = & claude-flow hive-mind status 2>$null
    if ($status) {
        Write-Host $status
    }
    
    Write-Host ""
    Write-Host "─" * 60 -ForegroundColor DarkGray
    Write-Host "Press Ctrl+C to exit | Refresh: ${RefreshInterval}s" -ForegroundColor Gray
}

# Main monitoring loop
try {
    while ($Continuous) {
        Show-Dashboard
        Start-Sleep -Seconds $RefreshInterval
    }
}
catch {
    Write-Host "`nMonitoring stopped." -ForegroundColor Yellow
}
finally {
    Write-Host "Dashboard closed at $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Gray
}