FROM archlinux

RUN pacman -Syu --noconfirm git sudo base-devel && \
    useradd -G wheel archuser && \
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
