FROM lightningcli:24.5
RUN lightningcli decode
RUN lightningcli encode
RUN lightningcli signmessage

FROM lightningcli:latest
FROM baseImage 
FROM baseImage
