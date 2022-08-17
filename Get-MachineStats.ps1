<# Ce script vérifie le status d'un serveur #>

<# Demande le nom du serveur à analyser et le stocke dans la variable "server". #>
$server = Read-Host -Prompt "Entrez le nom du serveur pour voir son status (localhost par default)"

<# Si le nom du serveur n'est pas renseigné, alors(?) il set la variable comme "localhost". #>
<# if (server -eq "") {
    $server = "localhost"
} #>
$server = ($server -eq "") ? "localhost" : $server 

<# Récupere les informations de la machine "server" et le stocke dans la variable "$os". #>
$os = Get-CimInstance Win32_OperatingSystem -ComputerName $server

<# Création de deux variables pour permettre de réaliser des calculs, parce que "TotalVisibleMemorySize" et "FreePhysicalMemory" sont fournis en format kilobyte. Ensuite, la fonction "[math]::Round(() ..., 2)" est utilisée pour permetre d'afficher les valeurs avec deux cas décimaux. #>
$memTotal = [math]::Round(($os.TotalVisibleMemorySize / 1MB), 2)
$memAvailable = [math]::Round(($os.FreePhysicalMemory / 1MB), 2)

<# Affiche sur l'écran le status de la machine #>
Write-Host "Stats for $server" -ForegroundColor Green
Write-Host ('-' * 25)
Write-Host "Total Memory        : $memTotal GB"
Write-Host "Available Memory    : $memAvailable GB"
Write-Host "Used Memory         : $($memTotal - $memAvailable) GB"
Write-Host "Operating System    : $($os.Caption)"
Write-Host "System Drive        : $($os.SystemDrive)\"