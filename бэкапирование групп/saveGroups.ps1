#Бронников 28.07.2011
#Скрипт по ADSI получает локальные группы с членами
#и генерирует скрипт для создания их на новос червере
Function Get-LocalGroup()
{
  $Computer = "localhost"
  $MemberNames = @()
  [Array]$local = net localgroup | ?{ $_ -match "^\*.*" } | %{ $_.SubString(1) }
  [Array]$gr =  $local | ? {$_ -like 'ora_*' -and $_ -notlike 'ora_dba*'}       
  #генерируем скрипт выполнения
  '$adsi = [ADSI]"WinNT://localhost"' | Out-File ./group.ps1 
   $cnt = $gr.Length
   for ($i=0;$i -lt $cnt;$i++)
   {
     #сохраняем группы
        "#добавление групп" | Out-File -Append ./group.ps1
        '$objgroup = '+'$adsi.Create('+'"Group"'+",'$($gr[$i])')"| Out-File -Append ./group.ps1
        '$objgroup.SetInfo()' | Out-File -Append ./group.ps1   
         "#--------------------------------" | Out-File -Append ./group.ps1
         $g = $gr[$i]
        $Group = [ADSI]"WinNT://$Computer/$g,group"
        $Members = @($Group.psbase.Invoke("Members"))
        [Array]$MemberNames = $Members | ForEach-Object {$_.GetType().InvokeMember("Name", 'GetProperty', $null, $_, $null)}
         #добавление в группы пользователей
        '$group = [ADSI]"WinNT://localhost/'+"$g,group"+'"'  | Out-File -Append ./group.ps1
         "#добавление членов" | Out-File -Append ./group.ps1
            "#------------------------------" | Out-File -Append ./group.ps1
          if ($MemberNames.Length -ne $null)
		  {
		  $MemberNames | % { '$group.add("WinNT://localhost/'+"AD/$_"+'")'  | Out-File -Append ./group.ps1}
   			}
   }
   
 }
 get-localGroup
