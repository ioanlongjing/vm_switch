::set vmrun="C:\Program Files (x86)\VMware\VMware Workstation\vmrun.exe"
::set vm1="C:\Users\corec\Documents\Virtual Machines\Windows 10 x64\Windows 10 x64.vmx"
::set vm2="C:\Users\corec\Documents\Virtual Machines\Windows10_Clone\Windows10_Clone.vmx"
set vmlog="C:\Users\corec\Desktop\vmlog.txt"
set vm_run="2"
echo %time%

echo "Start time" >> %vmlog%
echo %time >> %vmlog%

set /A _lasttime=%time:~0,2%*3600^
            +%time:~3,1%*10*60^
            +%time:~4,1%*60^
            +%time:~6,1%*10^
            +%time:~7,1% >nul

:loop
timeout 5 > NUL
set /A _nowtime=%time:~0,2%*3600^
            +%time:~3,1%*10*60^
            +%time:~4,1%*60^
            +%time:~6,1%*10^
            +%time:~7,1% >nul

set /A _elapsed=%_nowtime%-%_lasttime%

echo %_nowtime%
echo %_lasttime%
echo %_elapsed%

:: if worktime
if %time:~0,2% lss 19 (
if %time:~0,2% geq 8 (
    %vmrun% suspend %vm1% 
    %vmrun% suspend %vm2% 
    )
)

:: vm switch time
:: work for 7 
if %time:~0,2% geq 19 (

    if %_elapsed% gtr 16200 
    (
        set _lasttime = %_nowtime%
        if %vm_run% == "1" (
            %vmrun% suspend %vm1% 
            %vmrun% start %vm2%
            set vm_run="2"
        ) else (
        if %vm_run% == "2" (
            %vmrun% suspend %vm2% 
            %vmrun% start %vm1%
            set vm_run="1"
        )
        )
    )

    if %_elapsed% leq 0 (
        set _lasttime = %_nowtime%
        if %vm_run% == "1" (
            %vmrun% suspend %vm1% 
            %vmrun% start %vm2%
            set vm_run="2"
        ) else (
        if %vm_run% == "2" (
            %vmrun% suspend %vm2% 
            %vmrun% start %vm1%
            set vm_run="1"
        )
        )
    )
)

if %time:~0,2% lss 8 (

    if %_elapsed% gtr 16200 
    (
        set _lasttime = %_nowtime%
        if %vm_run% == "1" (
            %vmrun% suspend %vm1% 
            %vmrun% start %vm2%
            set vm_run="2"
        ) else (
        if %vm_run% == "2" (
            %vmrun% suspend %vm2% 
            %vmrun% start %vm1%
            set vm_run="1"
        )
        )
    )

    if %_elapsed% leq 0 (
        set _lasttime = %_nowtime%
        if %vm_run% == "1" (
            %vmrun% suspend %vm1% 
            %vmrun% start %vm2%
            set vm_run="2"
        ) else (
        if %vm_run% == "2" (
            %vmrun% suspend %vm2% 
            %vmrun% start %vm1%
            set vm_run="1"
        )
        )
    )
)
goto loop