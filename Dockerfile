FROM alex5402/endeavouros

# update all packages
RUN pacman -Syu --noconfirm

# install pipx, ansible
RUN pacman -S python-pipx --noconfirm
COPY constraints.txt /root/
RUN pipx install --include-deps ansible --pip-args "-c /root/constraints.txt"

# create de-privileged user
RUN useradd -ms /bin/bash user
RUN mkdir -p /app /home/user && chown user /app /home/user
USER user
WORKDIR /home/user
