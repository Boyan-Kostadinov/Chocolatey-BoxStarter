﻿$updatedOn = '2017.06.02 17:27:27'

# This is needed so we can get the WebAdministration module
Enable-WindowsOptionalFeature -FeatureName IIS-WebServer -Online -All -NoRestart | Out-Null