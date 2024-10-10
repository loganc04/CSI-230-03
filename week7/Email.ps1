function SendAlertEmail($Body) {
    $email = Read-Host "Enter email"
    $From = $email
    $To = $email
    $Subject = "Suspicious Activity"

    $Password = Read-Host "Enter password (with spaces)" -AsSecureString
    $Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $From, $Password

    Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer "smtp.gmail.com" -port 587 -UseSsl -Credential $Credential
}
