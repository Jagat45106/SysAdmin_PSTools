Write-Host "Example:  C:\Temp || D:\Data || E:\Personal\Docs" -ForegroundColor Yellow
$FolderPath = Read-Host "Enter Folder Path"

      try {
               $ColItems= Get-ChildItem $FolderPath -ErrorAction Stop            
 
#Calculate folder size

      	 Write-Host "Starting collecting folder size........" -ForegroundColor Green

		ForEach ($i in $ColItems)
		         {
           $subFolders =   Get-ChildItem -Path $i.FullName -Recurse  | Measure-Object -sum Length
         
# Math Operation

		ForEach ($subFolder in $subFolders) {

		$si = If (($subFolder.Sum -ge 1000000000)) {"{0:N2}" -f ($subFolder.Sum / 1GB) + " GB"} 
 	  	ElseIf (($subFolder.Sum -ge 10000000 -and $subFolder.Sum -lt 1000000000)  ) {"{0:N2}" -f ($subFolder.Sum / 1MB) + " MB"}
        ElseIf (($subFolder.Sum -lt 10000000)  ) {"{0:N2}" -f ($subFolder.Sum / 1KB) + " KB"}  

 # Creating PS Custom Object

		$Object = New-Object PSObject -Property @{            
        'FolderName'    = $i.Name                
        'Size'    =  $si
        'FullPath'    = $i.FullName
        "Folder" = $i.PSIsContainer        
                             }
       $Object | Select FolderName,Size,FullPath,Folder | Export-Csv .\Foldersize.csv -Append
        Write-Host "Calculating size of: " $i.FullName -ForegroundColor Cyan
                  } 
      
           }
     }

             catch {
                    
                 Write-Warning "The folder name is incorrect"
             
             }



		
        