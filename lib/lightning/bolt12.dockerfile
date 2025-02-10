FROM lightningcli:24.5
RUN lightningcli decode
RUN lightningcli encode
RUN lightningcli signmessage

FROM lightningcli:latest
FROM baseImage 

RUN lightningcli decode
RUN lightningcli encode
RUN lightningcli signmessage
RUN lightningcli offer
RUN lightningcli offer_channel

RUN lightningcli offer_channel --help