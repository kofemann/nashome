# Based on Fedora 28
FROM fedora:branched

MAINTAINER dCache "Tiramisu Mokka <kofemann@gmail.com>"

RUN dnf install --refresh -y samba
RUN dnf clean all

COPY smb.conf /etc/samba/smb.conf

RUN useradd -U -c "Samba User" samba
RUN echo -e "letme1n\nletme1n" | smbpasswd -s -a samba

RUN mkdir /data
RUN chown samba:samba /data

COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 137/udp 138/udp 139 445


HEALTHCHECK --interval=60s --timeout=15s \
   CMD smbclient -L '\\localhost\' -U 'guest%' -m SMB3`

VOLUME /data
CMD ["/run.sh"]

