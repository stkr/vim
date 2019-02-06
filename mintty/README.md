### Host specific config files

In order to have host specific settings on top of the generic settings, it is possible to specify
additional config files with the -c option.

We use the following naming convention for the config files:

    config_%COMPUTERNAME%_%USERNAME%

mintty itself uses the config file ~/.config/mintty/config per default, therefore by creating a
symling of this directory to ~/config/mintty, a multi layer configuration scheme can be achieved by
doing the following (e.g. form the toatlcmd start menu):

     C:\cygwin64\bin\mintty.exe -c %USERPROFILE%\.config\mintty\config_%COMPUTERNAME%_%USERNAME%
