# Exclude-UURemoteWARP.ps1
# 自动检测 UU远程 (GameViewer.exe) 的目标IP并将其排除出 Cloudflare WARP 的代理隧道
$ErrorActionPreference = "SilentlyContinue"

Write-Host "正在检测 UU远程 (GameViewer.exe) 的网络连接..." -ForegroundColor Cyan
$uu_processes = Get-Process | Where-Object {$_.ProcessName -match "GameViewer" -or $_.Description -match "UU"}

if (-not $uu_processes) {
    Write-Host "未找到正在运行的 UU远程 进程。请先启动 UU远程并成功连接后再运行此脚本。" -ForegroundColor Yellow
    Write-Host "按任意键退出..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit
}

$pids = $uu_processes.Id
$connections = Get-NetTCPConnection -OwningProcess $pids -State Established

if (-not $connections) {
    Write-Host "当前没有检测到 UU远程 的外网连接。" -ForegroundColor Yellow
    Write-Host "按任意键退出..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit
}

$remoteIPs = $connections | Select-Object -ExpandProperty RemoteAddress -Unique
$warpCliPath = "C:\Program Files\Cloudflare\Cloudflare WARP\warp-cli.exe"

if (-not (Test-Path $warpCliPath)) {
    Write-Host "未找到 Cloudflare WARP 客户端 (warp-cli.exe)。" -ForegroundColor Red
    Write-Host "按任意键退出..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit
}

Write-Host "发现以下目标 IP，准备添加到 Cloudflare WARP 排除列表："
$added = 0
foreach ($ip in $remoteIPs) {
    # 忽略局域网和回环地址
    if ($ip -notmatch "^127\." -and $ip -notmatch "^10\." -and $ip -notmatch "^192\.168\." -and $ip -notmatch "^172\.(1[6-9]|2[0-9]|3[0-1])\." -and $ip -notmatch "::") {
        Write-Host "排除 IP: $ip" -ForegroundColor Green
        & $warpCliPath tunnel ip add $ip
        $added++
    }
}

if ($added -gt 0) {
    Write-Host "排除完成！UU远程 流量现在应该不再走 Cloudflare WARP 代理了。" -ForegroundColor Green
} else {
    Write-Host "没有发现需要排除的外网 IP。" -ForegroundColor Yellow
}

Write-Host "按任意键退出..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
