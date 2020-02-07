$uri = "https://localhost:44382/api/image/identifyObjects"

#test images path
Get-ChildItem ".\data" -File | 

Foreach-Object {

	#which file
	Write-Host $_

	#fire the request to the API
	$response = irm  $uri -Method Post -Form @{imagefile=($_)} -SkipCertificateCheck
	
	#did the engine match anything
	if ($response.objectList.length -gt 0)
	{
		Foreach ($taggedObject in $response.objectList)
		{
			if ($taggedObject.label -ne "cat") {
				Write-Host "WHO DIS! We found a .... $($taggedObject.description)" -ForegroundColor White -BackgroundColor Red

				$dataUri = "data:image/jpeg;base64,$($response.imageString)"
				Start-Process "chrome" $dataUri

			}
			else
			{
				Write-Host "Meow .... $($taggedObject.description)" 
			}
		}
	}
	
}


