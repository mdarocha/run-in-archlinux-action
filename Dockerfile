FROM archlinux

RUN pacman -Syu --noconfirm git sudo

RUN useradd archuser

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
