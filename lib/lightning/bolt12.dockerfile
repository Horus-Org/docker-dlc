FROM lightningcli 24.5
RUN lightningcli decode
RUN lightningcli encode
RUN lightningcli signmessage

FROM lightningcli bin
FROM baseImage 
FROM baseImage
