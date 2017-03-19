## Gitコマンドで不要になったRemote Branchを削除する.
gitでPullRequestをMergeしていただいた後、不要なBranchを消すのがマナー.  
Branch削除手順を示す.  

### 作成したBranchの削除
作成したinitialize Branchを例に進める.
```
$ git branch --remote
  origin/HEAD -> origin/master
  origin/initialize
  origin/master

$ git branch --remote --delete origin/initialize
Deleted remote branch origin/initialize (was bef13b6).

$ git push origin :initialize
Username for 'https://github.com': ogalush
Password for 'https://ogalush@github.com': (ヒミツ)

To https://github.com/ogalush/InstallL2tpAndStrongSwan.git
 - [deleted]         initialize
~~~ DeletedになればOK.
```

### 削除確認
Github.comのリポジトリを参照し、削除したBranch名が表示されなくなったらOK.  
[RepositryURL](https://github.com/ogalush?tab=repositories)

## 参考
* [Git で不要になったローカルブランチ・リモートブランチを削除する方法](http://qiita.com/iorionda/items/c7e0aca399371068a9b8)  

以上
