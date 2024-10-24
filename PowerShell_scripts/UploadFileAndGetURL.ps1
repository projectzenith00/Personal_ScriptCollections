Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process;

# Custom Function
function customPDF {
    # The authentication key (API Key)| Generated for free in https://app.pdf.co.
    $API_KEY = "***************";

    # Source PDF file
    $SourceFile = ".\file.pdf";

    # 1. RETRIEVE THE PRESIGNED URL TO UPLOAD THE FILE.

    # `Get Presigned URL` API call
    $query = "https://api.pdf.co/v1/file/upload/get-presigned-url?contenttype=application/octet-stream&name=" + `
        [System.IO.Path]::GetFileName($SourceFile);
    $query = [System.Uri]::EscapeUriString($query);

    try {
        # Execute request
        $jsonResponse = Invoke-RestMethod -Method Get -Headers @{ "x-api-key" = $API_KEY } -Uri $query;
        
        if ($jsonResponse.error -eq $false) {
            # Get URL to use for the file upload
            $uploadUrl = $jsonResponse.presignedUrl;
            # Get URL of uploaded file to use with later API calls
            $uploadedFileUrl = $jsonResponse.url;

            # 2. UPLOAD THE FILE TO CLOUD.

            $r = Invoke-WebRequest -Method Put -Headers @{ "x-api-key" = $API_KEY; "content-type" = "application/octet-stream" } -InFile $SourceFile -Uri $uploadUrl;
            
            if ($r.StatusCode -eq 200) {
                
               Write-Host "Uploaded File URL: `"$($uploadedFileUrl)`" file.";
            }
            else {
                # Display request error status
                Write-Host $r.StatusCode + " " + $r.StatusDescription;
            }
        }
        else {
            # Display service reported error
            Write-Host $jsonResponse.message;
        }
    }
    catch {
        # Display request error
        Write-Host $_.Exception;
    }
}

# Calling the Function
customPDF;
