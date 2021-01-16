FROM archlinux

RUN pacman -Syu --noconfirm git sudo base-devel

RUN useradd archuser

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
