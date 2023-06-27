$minId = 3671 ##min is 101
$maxID = 85088
$urlformat = 'https://search.follettsoftware.com/metasearch/rest/v2/users/current?pl='

for ($id = $minId; $id -le $maxID; $id++) {
    $query = $null
    $url = $urlformat + $id
    $portalurl = "https://search.follettsoftware.com/metasearch/ui/$id"
    
    
    $query = Invoke-RestMethod $url -TimeoutSec 10

    $hash = @{
        ID           = $id
        SchoolName   = $query.siteName
        DistrictName = $query.districtName
        PortalUrl    = $portalurl
    }
    
    $hash.DistrictName -ne ''

    if (!($hash.SchoolName -eq $null)){

        New-Object PSOBject -Property $hash | Export-Csv .\portals.csv -Append

    }

    Start-Sleep -Seconds (Get-Random -Minimum 1 -Maximum 6)
}



