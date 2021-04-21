@echo off
rem The Wizard's Apprentice Installer
rem Example file that goes with the Wizard's Apprentice.
rem The Wizard's Apprentice may be freely distributed.
rem See license for details.

rem Increase the environment size to make sure all variables fit.
rem Call ourselves with a special first command line parameter...
rem On NT and newer, use %*
rem if not "%1"=="EnvSizeIncreased" %COMSPEC% /e:8192 /c %0 EnvSizeIncreased %1 %2 %3 %4 %5 %6 %7 %8 %9
rem ... and exit.
rem if not "%1"=="EnvSizeIncreased" goto :end
rem If we were called with the special command line parameter, we get
rem here: Remove the special command line parameter in case we have
rem other command line parameters.
rem if "%1"=="EnvSizeIncreased" shift

rem The Wizard starts here.
rem This is a useful set to reduce typing
set wizapp=start /w WizApp.exe
rem Display a splash screen. Do before all others, it doesn't need much
rem and will probably never fail.
set wabmp=
%wizapp% SPLASH OPEN
rem Set the title, the bitmap and the return batch file for this wizard,
rem and initialise all other wa variables in case any old values are
rem left over.
set watitle=Wizard's Apprentice Installation
set wabat=%TEMP%\wabat.bat
rem remove any leftovers
set waprefix=
set waeol=
set wainput=
set wafile=
set walistsep=
set walabels=
set wasig=
set wasound=
set waico=
set waoutput=
set waoutnum=
rem Initialise the variables this wizard needs.
set notinpath=0
set installdir=
set i0=1
set i1=1
set installgroup=Wizard's Apprentice
set undo=
rem Start the wizard.
%wizapp% SPLASH CLOSE
:page1
rem We set the page variable to be able to return here after a Cancel
rem request.
set page=:page1
set watext=Welcome To the Wizard's Apprentice Setup
rem When a text becomes too large, you can use more environment variables.
set watext2=~~This installation program will install the Wizard's Apprentice.
set watext3=~~The Wizard's Apprentice adds a user interface to your scripts:
set watext4=~~* Use message boxes for simple questions
set watext5=~* Tickboxes, radiobuttons and listboxes for complicated questions
set watext6=~* Display files, e.g. licenses
set watext7=~* Configurable buttons, picture and title
set watext8=~* File and directory box with Browse button
set watext9=~* Show splash screens, progress bars and play sounds
set watext10=~* Sample batch files and comprehensive manual
set watext11=~~... and the Wizard's Apprentice is free!
set watext12=~~Press the [Next] button to start the installation.
%wizapp% NOBACK TB
set watext2=
set watext3=
set watext4=
set watext5=
set watext6=
set watext7=
set watext8=
set watext9=
set watext10=
set watext11=
set watext12=
if errorlevel 2 goto :cancel
rem no Back possible

:page2
set page=:page2
set watext=Software License Agreement
set watext2=~~Although the Wizard's Apprentice is free, there still is a license. Hit the [I Accept] button to continue installing.
rem wafile contains the contents for the license box.
set wafile=license.txt
set wainput=
rem The ^ is necessary to escape the ampersand on NT,
rem The ampersand puts in a hotkey.
if "%OS%"=="Windows_NT" set walabels=;I ^&Accept;;I ^&Disagree;
if not "%OS%"=="Windows_NT" set walabels=;I &Accept;;I &Disagree;
%wizapp% FT
set watext=
set watext2=
rem Don't forget to set wafile to empty; if both wafile and wainput are
rem set, wafile wins.
set wafile=
rem And set the labels back to normal.
set walabels=
if errorlevel 2 goto :exit
if errorlevel 1 goto page1

:page3
set page=:page3
set watext=Do you want to install the Wizard's Apprentice in a directory in your PATH?
set watext2=~~If you install in your PATH, the Wizard's Apprentice will be available everywhere on you computer.
set watext3=~If you don't, it has to reside in the same directory as the batch file that uses it, or you must call it by its full path name.
rem Set the radiobutton options
if "%OS%"=="Windows_NT" set wainput=Install in my ^&PATH;Install in ^&another directory
if not "%OS%"=="Windows_NT" set wainput=Install in my &PATH;Install in &another directory
rem Set the initially checked choice
set waoutnum=%notinpath%
set waoutput=
%wizapp% RB
set watext=
set watext2=
set watext3=
if errorlevel 2 goto :cancel
if errorlevel 1 goto page2
rem Retrieve the user's choice
call %wabat%
rem and store it
set notinpath=%waoutnum%

rem Now we have the choice: Either we show a dialog that shows all
rem directories in the path, or we show a normal directory browser.
rem First comes the PATH chooser.
:page4
rem Check whether we should display this page at all; skip it if we
rem shouldn't.  The user can come from the previous page (after pressing
rem the Next button) or from the next page (with the Back button);
rem handle both case.
if %notinpath%==1 if %page%==:page3 goto :page5
if %notinpath%==1 if %page%==:page5 goto :page3
rem Now that we got here, we do want to display this page.
set page=:page4
set watext=Select Destination Directory in your PATH
set watext2=~~~~Please select the directory in your PATH where the Wizard's Apprentice should be installed.
set waoutput=%installdir%
set waoutnum=
set wainput=%PATH%
%wizapp% LB SINGLE
set watext=
set watext2=
if errorlevel 2 goto :cancel
if errorlevel 1 goto page3
rem Retrieve the user's choice
call %wabat%
rem and store it
set installdir=%waoutput%

rem Next comes the normal directory browser. 
:page5
if %notinpath%==0 if %page%==:page4 goto :page6
if %notinpath%==0 if %page%==:page6 goto :page4
set page=:page5
set watext=Select Destination Directory
set watext2=~~~~Please select the directory where the Wizard's Apprentice should be installed.
set waoutput=%installdir%
set waoutnum=
%wizapp% FB DIR
set watext=
set watext2=
if errorlevel 2 goto :cancel
if errorlevel 1 goto page4
rem Retrieve the user's choice
call %wabat%
rem and store it
set installdir=%waoutput%

:page6
set page=:page6
set watext=Icon Creation
set watext2=~~~~Should the installer create a desktop icon or a shortcut in the start menu for the Wizard's Apprentice's Manual?
if "%OS%"=="Windows_NT" set wainput=Add manual to ^&Start Menu;Add manual icon to ^&Desktop
if not "%OS%"=="Windows_NT" set wainput=Add manual to &Start Menu;Add manual icon to &Desktop
rem By setting waoutnum we specify the default value. 
set waoutnum=
if %i0%==1 set waoutnum=0;
if %i1%==1 set waoutnum=%waoutnum%1;
set waoutput=
%wizapp% CL
set watext=
set watext2=
if errorlevel 2 goto :cancel
if errorlevel 1 goto page5
call %wabat%
rem Here's a trick to dissect the list that was returned. These 'for'
rem commands create variables named i0, i1
for %%n in (0 1) do set i%%n=0
rem i0 is only set if 0 is in the list. i1 will only be set if 1 is in
rem the list, etc.
for %%n in (%waoutnum%) do set i%%n=1

:page7
rem Here we have another page that we sometimes must skip, depending on
rem the value of i0.  
if "%i0%"=="0" if %page%==:page6 goto page8
if "%i0%"=="0" if %page%==:page8 goto page6
set page=:page7
rem find all the groups in the user's start menu.
set userdir=%USERPROFILE%
rem USERPROFILE is not set on Windows 95/98.  This solution isn't
rem entirely correct on Windows 9x, as you might have profiles enabled,
rem but it is better than nothing.  For a better solution, see the
rem websites referred to in the manual.
if "%USERPROFILE%"=="" set userdir=%windir%
rem If wafile is set, it's contents will be used instead of wainput. So
rem we build the directory list in a file. Note that walistsep is not
rem used then; every line is an item.
set wafile=%TEMP%\wafile
rem dir /ad lists only directories, /b means bare output (only names)
dir /ad /b "%userdir%\Start Menu\Programs" > %wafile%
set wainput=
rem Now we have the list for the combobox; Setting waoutput sets the
rem default for the combobox's editfield.
set waoutput=%installgroup%
set waoutnum=
set watext=Select Group
set watext2=~~~~Enter the name of program group to add the manual icon to.
%wizapp% CB
set watext=
set watext2=
rem Don't forget to set wafile to empty; if both wafile and wainput are
rem set, wafile wins.
set wafile=
if errorlevel 2 goto :cancel
if errorlevel 1 goto page6
call %wabat%
set installgroup=%waoutput%

:page8
set page=:page8
set watext=Ready to Install!
set watext2=~~~~Press the [Install] button to begin the installation or the [Back] button to reenter the installation information.~
rem Here we use a file text box with only a few lines of text, so we use
rem wainput instead of wafile.
set wainput=Installation directory: %installdir%
if "%i0%"=="1" set wainput=%wainput%~Install a shortcut to the manual in program group: %installgroup%
if "%i1%"=="1" set wainput=%wainput%~Install a shortcut to the manual on your Desktop
if "%OS%"=="Windows_NT" set walabels=;;^&Install;;
if not "%OS%"=="Windows_NT" set walabels=;;&Install;;
%wizapp% FINISH FT
set watext=
set watext2=
if errorlevel 2 goto :cancel
if errorlevel 1 goto page7

rem Here we are, after the user pressed the Install button. Let's
rem install! 
rem Display a progress bar.
set watext=Installing...
set watext2=~~Creating directory...
rem This instance of the program runs asynchronously. Subsequent calls of
rem wizapp PB will talk to this instance.
%wizapp% PB OPEN
rem We don't get an errorlevel here, as this instance is still running.

rem Just create the directory and ignore the error message if it does
rem not work.
mkdir "%installdir%" > nul
rem When the user presses Cancel in the progress dialog, we will notice
rem after the next PB UPDATE. Here we set a "checkpoint" so we can
rem cancel an incomplete installation.
rem Note that in this program, we can always undo everything by deleting
rem the whole installation, but this is more instructive.
set undo=:undomkdir
rem watext2 is used to tell the user what the next step is. Note that
rem watext is unchanged; it always reads 'Installing...'
set watext2=~~Copying program...
rem Setting the correct percentages of the progress bar is a matter of
rem guessing. The most important thing is to get the copying of large
rem files right.
%wizapp% PB UPDATE 4
if errorlevel 2 goto :cancel
rem The Back button does not work in a progress dialog.

rem By specifying a complete path name for the destination we make sure
rem the copy fails if the directory name is not valid.
copy "wizapp.exe" "%installdir%\wizapp.exe" > nul
set undo=:undocpexe
set watext2=~~Copying help file...
%wizapp% PB UPDATE 32
if errorlevel 2 goto :cancel
copy "wizapp.chm" "%installdir%\wizapp.chm" > nul
set undo=:undocpchm
set watext2=~~Copying other files...
%wizapp% PB UPDATE 91
if errorlevel 2 goto :cancel
copy "wainstall.bat" "%installdir%\wainstall.bat" > nul
copy "license.txt" "%installdir%\license.txt" > nul
copy "versions.txt" "%installdir%\versions.txt" > nul
copy "wizapp.xml" "%installdir%\wizapp.xml" > nul
set undo=:undocprest
set watext2=~~Creating shortcuts...
%wizapp% PB UPDATE 98
if errorlevel 2 goto :cancel
rem Now create the shortcut, first in TEMP
set linkname=The Wizard's Apprentice's Manual
rem Create an .inf file, also in TEMP
echo [version]                  > %TEMP%\tmp.inf
echo signature=$chicago$        >> %TEMP%\tmp.inf
echo [DefaultInstall]           >> %TEMP%\tmp.inf
echo UpdateInis=AddLink         >> %TEMP%\tmp.inf
echo [AddLink]                  >> %TEMP%\tmp.inf
echo setup.ini, progman.groups,, ""group1="%TEMP%""" >> %TEMP%\tmp.inf
echo setup.ini, group1,, """%linkname%"", """"""%installdir%\wizapp.chm""""""" >> %TEMP%\tmp.inf
rem Create the link
start /w rundll32.exe setupapi,InstallHinfSection DefaultInstall 132 %TEMP%\tmp.inf
del %TEMP%\tmp.inf
rem Copy it to wherever we wanted
if "%i0%"=="0" goto :desktop
rem Just create the directory and ignore the error message if it doesn't
rem work.
mkdir "%userdir%\Start Menu\Programs\%installgroup%" > nul
rem Again, by using the full name the copying is reasonably safe.
copy "%TEMP%\%linkname%.lnk" "%userdir%\Start Menu\Programs\%installgroup%\%linkname%.lnk" > nul
:desktop
if "%i1%"=="0" goto :linkdone
copy "%TEMP%\%linkname%.lnk" "%userdir%\Desktop\%linkname%.lnk" > nul
:linkdone
del "%TEMP%\%linkname%.lnk"
set undo=:undolinks
rem Don't forget to show the user a 100% filled progress bar, even if it
rem is only a quick flash!
set watext2=~~Done!
%wizapp% PB UPDATE 100
if errorlevel 2 goto :cancel
set watext=
set watext2=

%wizapp% PB CLOSE

set watext=Installation completed!
%wizapp% MB INFO

goto :exit

:cancel
set watext=Do you want to abort this installation?
%wizapp% MB QUES
if errorlevel 2 goto %page%
rem The user wants to cancel installation, 
rem so we must uninstall what's been done. Above, we set
rem the undo variable to keep track of what to undo. If undo is not set,
rem just exit
if "%undo%"=="" goto :exit
rem if undo is set, there is a progress bar on the screen. Close it.
%wizapp% PB CLOSE
rem And undu the installation steps.
goto %undo%
rem Here we undo the installation in the reverse order. Any checkpoint
rem we didn't get to will not be undone.
:undolinks
if "%i0%"=="1" del "%userdir%\Start Menu\Programs\%installgroup%\%linkname%.lnk"
if "%i0%"=="1" rmdir "%userdir%\Start Menu\Programs\%installgroup%"
if "%i1%"=="1" del "%userdir%\Desktop\%linkname%.lnk"
:undocprest
del "%installdir%\wainstall.bat"
del "%installdir%\license.txt"
del "%installdir%\versions.txt"
del "%installdir%\wizapp.xml"
:undocpchm
del "%installdir%\wizapp.chm"
:undocpexe
del "%installdir%\wizapp.exe"
:undomkdir
rem Note that we don't delete the contents, as maybe the directory
rem already existed. When an empty dir was already there, it will be
rem gone, but at least no files are destroyed.
rmdir "%installdir%"

:exit
set wizapp=
if not "%wabat%"=="" if exist %wabat% del %wabat%
set userdir=
set installdir=
set installgroup=
if exist %TEMP%\wafile del %TEMP%\wafile
set undo=
set linkname=
set notinpath=
set page=
set i0=
set i1=

set waprefix=
set watitle=
set watext=
set wainput=
set waeol=
set walistsep=
set wafile=
set wabmp=
set walabels=
set wasig=
set wasound=
set waico=
set wabat=
set waoutput=
set waoutnum=
:end
