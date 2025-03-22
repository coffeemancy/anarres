FROM alex5402/endeavouros

# update all packages
RUN pacman -Syu --noconfirm

# install pipx
RUN pacman -S python-pipx --noconfirm

# create de-privileged user, but give passwordless sudo access
RUN useradd -ms /bin/bash user \
 && mkdir -p /app /home/user/.local/bin && chown user -R /app /home/user \
 && echo export PATH="\$PATH:/home/user/.local/bin" >> "/home/user/.bashrc" \
 && echo source "/home/user/.bashrc" >> "/home/user/.profile" \
 && echo "%user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# install ansible with pipx for user
USER user
COPY constraints.txt /home/user
RUN pipx install --include-deps ansible --pip-args "-c /home/user/constraints.txt"

WORKDIR /home/user
