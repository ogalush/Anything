# MacOSの .DS_Store を無効化する方法
MacOSで `.DS_Store` のファイルが表示されて不要なため作成しない様にする設定.  

参考: https://lovemac.jp/9906#litob-toc-item-1

# .DS_Store とは
MacOSのFinderで、当該ディレクトリを閲覧した際にカスタマイズした設定を置いておくファイルとのこと.

# 削除方法
## .DS_Store 無効化
```
@MacOS
% defaults write com.apple.desktopservices DSDontWriteNetworkStores True
% killall Finder
```

## .DS_Store ファイルを削除
もう使用しないため削除する.
```
@MacOS
$ find /Volumes/Macintosh\ HD/ -name '.DS_Store'
→ ファイルが有る場合は、削除を行う。
$ find /Volumes/Macintosh\ HD/ -name '.DS_Store' -exec rm -v {} \;
→ 削除が成功すること。
```
