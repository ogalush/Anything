# coding: UTF-8
import sys

## For Python27

## URL
#https://www.pythonweb.jp/tutorial/

# Print String Encodings.
#print sys.stdin.encoding
#print sys.stdout.encoding
#print sys.stderr.encoding


## 文字列連結
##print "Hello", "!","world."

## Here Documents.
##print """Hoge
##Fuga
##Gya"""

## Perform
##sum = 10 + 45
##print sum

## if
##sum = 0
##if sum > 0:
## print "SUM > 0 (true)です."
##else:
## print "SUM <= 0 (else)です."

## array
##list = [100, 200, 300, 400, 500]
##print list[2]

##
##plist = [u"山田", u"太郎", 12, 31, u"男性"]
##print u"氏名: " + plist[0] + plist[1]
##print u"生年月日: " + str(plist[2]) + "/" + str(plist[3])
##print u"性別: " + plist[4]

## list
##plist = [u"山田", u"太郎", 12, 31, u"男性"]
##print plist[0:1]

## keyvalue
##keyvalue = {"yamada":75, "endou":82}
##print keyvalue["yamada"]

## while
##num = 0
##while num <= 2:
##  print "num = " + str(num)
##  num += 1
##print "End"

## for
for num in [1, 2, 3, 4, 5]:
  print "num = " + str(num)
print "End"
