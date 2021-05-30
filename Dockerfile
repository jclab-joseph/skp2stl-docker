FROM mcr.microsoft.com/windows/servercore:20H2
#FROM mcr.microsoft.com/windows/nanoserver:20H2
MAINTAINER Joseph Lee <joseph@jc-lab.net>

ADD [ "vc_redist.x64.exe", "C:/" ]
RUN "C:\\vc_redist.x64.exe" /install /passive /norestart

COPY [ "program", "C:/program/" ]

ADD "empty-card.skp" "C:/"



