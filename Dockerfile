FROM archlinux

RUN pacman -Syu --noconfirm base-devel git sudo gnupg && \
    useradd -m -G wheel archuser && \
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
