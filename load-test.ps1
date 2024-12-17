# Configuration
$webAppUrl = "http://127.0.0.1:60757/"  # Replace with your web app's URL
$totalRequests = 10000            # Total number of requests to send
$concurrentRequests = 10           # Number of concurrent requests

# Function to send a GET request
function Send-GetRequest {
    param (
        [string]$url
    )
    try {
        $response = Invoke-WebRequest -Uri $url -Method GET -ErrorAction Stop
        Write-Host "Status Code: $($response.StatusCode)" -ForegroundColor Green
    } catch {
        Write-Host "Request failed: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Function to run concurrent requests
function Run-ConcurrentRequests {
    param (
        [string]$url,
        [int]$requests
    )
    $jobs = @()
    for ($i = 1; $i -le $requests; $i++) {
        $jobs += Start-Job -ScriptBlock {
            # Use the Send-GetRequest function within the job scope
            param ($url)
            try {
                $response = Invoke-WebRequest -Uri $url -Method GET -ErrorAction Stop
                Write-Host "Status Code: $($response.StatusCode)" -ForegroundColor Green
            } catch {
                Write-Host "Request failed: $($_.Exception.Message)" -ForegroundColor Red
            }
        } -ArgumentList $url
    }

    # Wait for all jobs to complete
    $jobs | ForEach-Object { $_ | Wait-Job | Receive-Job }
    $jobs | ForEach-Object { Remove-Job -Job $_ }
}

# Main Execution Loop
for ($i = 1; $i -le ($totalRequests / $concurrentRequests); $i++) {
    Write-Host "Sending batch $i of $concurrentRequests requests..."
    Run-ConcurrentRequests -url $webAppUrl -requests $concurrentRequests
    Start-Sleep -Milliseconds 100  # Optional: Delay between batches
}

Write-Host "Load test completed."
