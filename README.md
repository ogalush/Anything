Anything
========

インストールスクリプトなど、役に立ちそうなソースを入れておくリポジトリ

## Ansible for Ubuntu 16.04
### Ansibleの最新パッケージをインストール
[参考](http://redj.hatenablog.com/entry/2016/12/17/100831)
```
$ sudo apt -y install software-properties-common
$ sudo apt-add-repository ppa:ansible/ansible
$ sudo apt -y update
$ sudo apt -y upgrade
→ または, sudo apt -y install ansible

$ ansible --version
ansible 2.4.3.0
  config file = /etc/ansible/ansible.cfg
  configured module search path = [u'/home/ogalush/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python2.7/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 2.7.12 (default, Dec  4 2017, 14:50:18) [GCC 5.4.0 20160609]
```

### OS Update実行
```
$ ansible-playbook apttarget.yml -i apttarget.list -K
```
