# gitでバージョンを刻む方法
git tagでバージョンを刻む.

# 方法
cloneする.
```
$ git clone ...
```
  
git tagを付ける
```
$ git tag -a v0.1 -m "Initial public version before improvements"
```
  
よくあるコメント例
```
v0.1
- Initial implementation
- TradingView iframe preview on hover
- Single-site support
```
    
pushする
```
$ git push origin v0.1
```
  
githubを確認する  
branch一覧の横に「tag」があるので付いていることを確認できればOK.
  
以上
