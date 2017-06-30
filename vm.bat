@echo off
set vmrun="C:\Program Files (x86)\VMware\VMware Workstation\vmrun.exe"
set vm1="C:\Users\corec\Documents\Virtual Machines\Windows 10 x64\Windows 10 x64.vmx"
set vm2="C:\Users\corec\Documents\Virtual Machines\Windows10_Clone\Windows10_Clone.vmx"
set vmlog="C:\Users\corec\Desktop\vmlog.txt"
set vm_run="2"
set rest_period=1

echo "start the vmrun" >> %vmlog%
echo %time%            >> %vmlog%
echo "===============" >> %vmlog%

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

set now_time=%time:~0,2%

if %now_time% lss 19 (
    if %now_time% geq 8 (
    %vmrun% suspend %vm1% 
    %vmrun% suspend %vm2% 
    echo "Both have suspend" >> %vmlog%
    set rest_period=1
    )
)

:: work for 19 to 24
if %now_time% geq 19 (
    if %rest_period% EQU 1 (
        set rest_period=2
        %vmrun% suspend %vm2%
        %vmrun% start %vm1% 
        echo %time% >>  %vmlog%
        echo "It is run 19 to 24. Stap A" >> %vmlog% 
        echo "start vm1 suspend vm2" >> %vmlog%
        echo "=====================" >> %vmlog%

        set _lasttime=%_nowtime%
    )
    if %_elapsed% gtr 900 (
        set _lasttime=%_nowtime%
        if %vm_run% == "1" (
            %vmrun% suspend %vm2%
            %vmrun% start %vm1%
            echo %time% >>  %vmlog%
            echo "It is run 19 to 24. Stap B" >> %vmlog% 
            echo "start vm1 suspend vm2" >> %vmlog%
            echo "=====================" >> %vmlog%

            set vm_run="2"
        ) else (
        if %vm_run% == "2" (
            %vmrun% suspend %vm1%
            %vmrun% start %vm2%
            echo %time% >>  %vmlog%
            echo "It is run 19 to 24. Stap C" >> %vmlog% 
            echo "start vm2 suspend vm1" >> %vmlog%
            echo "=====================" >> %vmlog%

            set vm_run="1"
        )
        )
        echo %_lasttime%
    )

    if %_elapsed% leq 0 (
        set _lasttime = %_nowtime%
        if %vm_run% == "1" (
            %vmrun% suspend %vm2%
            %vmrun% start %vm1%
            echo %time% >>  %vmlog%
            echo "It is run 19 to 24. Stap D" >> %vmlog% 
            echo "start vm1 suspend vm2" >> %vmlog%
            echo "=====================" >> %vmlog%

            set vm_run="2"
        ) else (
        if %vm_run% == "2" (
            %vmrun% suspend %vm1%
            %vmrun% start %vm2%
            echo %time% >>  %vmlog%
            echo "It is run 19 to 24. Stap E" >> %vmlog% 
            echo "start vm2 suspend vm1" >> %vmlog%
            echo "=====================" >> %vmlog%

            set vm_run="1"
        )
        )
    )
)

:: work for 00 to 08
if %now_time% lss 8 (
    echo "work for 00 to 08"
    if %_elapsed% gtr 900 (
        set _lasttime=%_nowtime%
        if %vm_run% == "1" (
            %vmrun% suspend %vm2%
            %vmrun% start %vm1%
            echo %time% >>  %vmlog%
            echo "It is run 19 to 24. Stap F" >> %vmlog% 
            echo "start vm1 suspend vm2" >> %vmlog%
            echo "=====================" >> %vmlog%

            set vm_run="2"
        ) else (
        if %vm_run% == "2" (
            %vmrun% suspend %vm2%
            %vmrun% start %vm1%
            echo %time% >>  %vmlog%
            echo "It is run 19 to 24. Stap G" >> %vmlog%
            echo "start vm2 suspend vm1" >> %vmlog%
            echo "=====================" >> %vmlog%

            set vm_run="1"
        )
        )
    )

    if %_elapsed% leq 0 (
        set _lasttime=%_nowtime%
        if %vm_run% == "1" (
            %vmrun% suspend %vm1%
            %vmrun% start %vm2%
            echo %time% >> %vmlog%
            echo "It is run 19 to 24. Stap H" >> %vmlog% 
            echo "start vm1 suspend vm2" >> %vmlog%
            echo "=====================" >> %vmlog%

            set vm_run="2"
        ) else (
        if %vm_run% == "2" (
            %vmrun% suspend %vm1%
            %vmrun% start %vm2%
            echo %time% >> %vmlog%
            echo "It is run 19 to 24. Stap I" >> %vmlog% 
            echo "start vm2 suspend vm1" >> %vmlog%
            echo "=====================" >> %vmlog%

            set vm_run="1"
        )
        )
    )
)


goto loop