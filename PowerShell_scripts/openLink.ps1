Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList '--kiosk', 'https://www.google.com/search?sca_esv=4a188d92a63a9538&sca_upv=1&sxsrf=ADLYWIKMTjtzfqm79taXHM5X1LyhSRexOw:1716347714498&q=bikini+ladies&uds=ADvngMj53AHIJt2KifqzVbYVXLyJ76wpMQYPWKkKP3HYos0XJ5ERWgXHBiuoBHz-oHCMhKoe72KTu4kvoUfGj7p3IZzTZHew5JmCsti3ViyWt4jlponu36O6iw0EcR_JOLDngVx2XbYmxbN_NB4YweUmQvkMt2dskTA-iQzKhdgixNzynpGm-Tyj4GVj6fRLhUb0yzKtwTnoJgEpaqCYHzJHXeEsIvf6LH3SKUCoyjIX4N8zI_CE57BxVJr7ERjXy2Cf3-qFXPodGr6pqtyA9W14hXz3n4Vq4O-LhLSF-9PDolRw6Y1gEtXkeSmM5r5b-L1YDRKLPZ6B&udm=2&prmd=ivsmnbtz&sa=X&ved=2ahUKEwjgodW-paCGAxWKfWwGHVkjDFkQtKgLegQICRAB&biw=1920&bih=919&dpr=1';
Start-Sleep -Seconds 2;
[System.Windows.Forms.SendKeys]::SendWait('{F11}');
[InputBlocker]::BlockInputForSeconds(60);
