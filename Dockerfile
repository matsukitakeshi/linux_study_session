FROM ubuntu:22.04

RUN apt update && apt install -y sudo openssh-server vim nano net-tools iputils-ping mysql-client
RUN mkdir /var/run/sshd

RUN groupadd training_admin_group
RUN useradd -m -s /bin/bash adminuser && echo "1234" | passwd --stdin adminuser || echo "adminuser:1234" | chpasswd
RUN usermod -aG training_admin_group adminuser

RUN sed -i 's/%sudo/# %sudo/' /etc/sudoers
RUN echo "%training_admin_group ALL=(ALL:ALL) ALL" >> /etc/sudoers
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
