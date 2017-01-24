# DevOps

## how to use

```
curl -s https://raw.githubusercontent.com/tecposter/devops/master/install/ubuntu-dotconfig-cn.sh | bash
```

## Prepare

new user

```
sudo useradd -m -s /bin/bash {UserName}
```

set password

```
passwd {UserName}
```

add user to sudo group

```
sudo usermod -a -G sudo {UserName}
```

sudo without password

add /etc/sudoers.d/{UserName}
```
{UserName} ALL=(ALL) NOPASSWD: ALL
```


Generate ssh keys:
[https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/)

```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

ssh login without password

```
ssh-copy-id {UserName}@example.com
```
or
```
cat ~/.ssh/id_rsa.pub | ssh {UserName}@example.com 'cat >> ~/.ssh/authorized_keys'
```

chang ssh port

edit /etc/ssh/sshd_config
```
# Port 22 
Port 5023
```

ssh config in clinet

edit ~/.ssh/config
```
Host example.com
    Port 5023
    User {UserName}
```


ubuntu upgrade to 16.04
```
sudo apt update
sudo apt upgrade
sudo do-release-upgrade
```
