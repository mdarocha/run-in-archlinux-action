FROM archlinux

# https://stackoverflow.com/a/66163228
RUN patched_glibc=glibc-linux4-2.33-4-x86_64.pkg.tar.zst && \
    curl -LO "https://repo.archlinuxcn.org/x86_64/$patched_glibc" && \
    bsdtar -C / -xvf "$patched_glibc"

RUN pacman -Syu --noconfirm base-devel git sudo gnupg && \
    useradd -m -G wheel archuser && \
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
