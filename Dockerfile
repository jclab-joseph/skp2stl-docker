FROM mcr.microsoft.com/windows/servercore:ltsc2019
#FROM mcr.microsoft.com/windows/nanoserver:20H2
MAINTAINER Joseph Lee <joseph@jc-lab.net>

RUN mkdir "C:\\temp"
ADD [ "vc_redist.x64.exe", "PowerShell-7.1.3-win-x64.msi", "C:/temp/" ]
RUN "C:\\temp\\vc_redist.x64.exe" /install /passive /norestart
RUN msiexec.exe /package C:\\temp\\PowerShell-7.1.3-win-x64.msi /quiet

COPY [ "program", "C:/program/" ]


### Begin workaround ###
# Note that changing user on nanoserver is not recommended
# See, https://docs.microsoft.com/en-us/virtualization/windowscontainers/manage-containers/container-base-images#base-image-differences
# But we are working around a bug introduced in the nanoserver image introduced in 1809
# Without this, PowerShell Direct will fail
# this command sholud be like this: https://github.com/PowerShell/PowerShell-Docker/blob/f81009c42c96af46aef81eb1515efae0ef29ad5f/release/preview/nanoserver/docker/Dockerfile#L76
USER ContainerAdministrator

# This is basically the correct code except for the /M
RUN setx PATH "%PATH%;%ProgramFiles%\PowerShell;C:\program" /M

USER ContainerUser
### End workaround ###


SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
CMD ["pwsh.exe"]

