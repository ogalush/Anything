from fabric.api import run,env,sudo,parallel
import getpass

#-- Execute CommandLine.
## fab -P -z 5 -f update_pkg.py update_pkg

#--Def
##env.hosts = ['www.teamlush.biz']
env.hosts = ['192.168.0.200', '192.168.0.210', '192.168.0.220']
#-- need password for parallel execute.
#-- http://blog.masu-mi.me/2015/04/11/fabric_tips.html
env.password = getpass.getpass('Enter the sudo password: ')

#env.use_ssh_config = true
#env.key_filename = "~/.ssh/id_rsa"
#--Def(END)


@parallel(pool_size=5)
def update_pkg():
  sudo('/etc/init.d/cpufrequtils start', pty=False)
  sudo('apt-get -y update', pty=False)
  sudo('apt-get -y upgrade', pty=False)
  sudo('apt-get -y dist-upgrade', pty=False)
  sudo('apt-get -y autoremove', pty=False)

def reboot():
  run('hostname')
  sudo('shutdown -r now', pty=False)
