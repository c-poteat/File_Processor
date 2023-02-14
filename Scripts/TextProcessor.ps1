function textProcessor {

    ## Script to create custom text files

    ## First Get current location
    $currentLocation = $pwd.path
    
    ## Next Create Name for text file
    $firstString = Read-Host "`nEnter the name of your file (File format defaulted to .txt)"
    $secondString = ".txt"
    $concatenatedString = $firstString + "" + $secondString
    
    ## Prompt for whether the user wants to save to a location
    $selectLocation = Read-Host "`nWould you like to save your file in the current directory $currentLocation ? Y or N"

    $outputPath = Join-Path $currentLocation $concatenatedString
    $newOutputPath = Join-Path "$HOME\Documents\" -ChildPath $concatenatedString

    ## Conditional
    
    if ($selectLocation -eq "YES" -or $selectLocation -eq "Y")  {
        Start-Sleep -Seconds 1.0
        try {
        
            New-Item $outputPath -ErrorAction stop
            #-ItemType File -Force
        }
        catch [System.IO.IOException] {
            Write-Host "`nFile with that name and extension already exists:" 
      }
    
    } else {
        $NewLocation = Write-Host "`nYour file will be saved to your Documents folder"
        $NewLocation
        Start-Sleep -Seconds 1.0
        New-Item $newOutputPath
    }

    # Add data to file contents
    $fileAdd = Read-Host "`nWould you like to add information within the file you created? Y or N" 
  
    if ($fileAdd -eq "Y" -or "Yes") {
        $insertData = Read-Host "`nType the data you want to enter"
        Add-Content -Path $outputPath -Value $insertData

    }
    # Display file contents
    "`nThe information shown below is listed within the file contents`n" 
    Get-Content $outputPath

    # Change file extension
    $filePrompt = Read-Host "`nWould you like to change the file extension of your file? Y or N"
 
    if ($filePrompt -eq "Y") {
        $fileConv = Read-Host "`nPlease type the extension you would like to change to, Example, .bat, .doc, .log, .txt"
        try {
            Get-ChildItem $outputPath | Rename-Item -NewName {$outputPath -Replace '\.txt$',$fileConv} -ErrorAction stop 

        }
        catch [System.IO.IOException] {
            Write-Host "`nFile already exists: $outputPath" 
        }
    }

    # Filter by common document file extensions

    $remoteFiles = Read-Host "`nDo you want to remove the file you created?"
    $stringResult = $firstString + "" + $fileConv

    # Remove file based upon file specific file extension 

    if ($remoteFiles -eq "Y" -and $filePrompt -eq "Y") {
        Remove-Item $stringResult  -Force 
        Write-Host "`n$stringResult was removed sucessfully"
        Start-Sleep -Seconds 1.0
        Get-childitem 

    } elseif ($remoteFiles -eq "Y" -and $filePrompt -eq "N") {
        Remove-Item $concatenatedString  -Force 
        Write-Host "`n$concatenatedString was removed sucessfully"
        Start-Sleep -Seconds 1.0
        Get-childitem 
}
    Write-Host "`nGoodbye, Have a nice day :)`n"
    Get-childitem 
}

