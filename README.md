# OT-Project

1.To start testing credential dumpers just start the batch file start_testing from test_tools_standalone folder (both variants x86 and x64 folders)

2. For testing VSS (used when testing prevention methods) run the test_vss.bat file

3. To save Registries just issue save_reg.bat file

4. The batch files used to automatically deploy Active Directory and to add users use following commands:
	PS C:\Users\Administrator\Desktop> set-executionpolicy remotesigned
	PS C:\Users\Administrator\Desktop\_AD_DC > dcpromo /unattend:unettend_dc.txt
        PS C:\Users\Administrator\Desktop\_AD_DC\_AD_> .\ou_create.ps1
        PS C:\Users\Administrator\Desktop\_AD_DC\_AD_\AddUserstoGroup> .\create_bulk_users.ps1
        PS C:\Users\Administrator\Desktop\_AD_DC\_AD_\AddUserstoGroup> .\create_users_2.ps1

5. To escalate to SYSTEM run : 
        CMD: cd  C:\Users\user01\Downloads\PSTools
        PSEXEC -i -s -d CMD

6. To start VMs and push all set of cred dumpers to open vms check the start_vms_test folder and start the batch file run_scenario_1(bat) - this is not the last version of the file. If you want all of the automatic workflow code I used please contact me at drusu@os3.nl. Thanks!
   
